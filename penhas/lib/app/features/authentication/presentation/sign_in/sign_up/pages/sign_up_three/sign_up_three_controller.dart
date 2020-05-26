import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'sign_up_three_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class SignUpThreeController extends _SignUpThreeControllerBase
    with _$SignUpThreeController {
  SignUpThreeController(IUserRegisterRepository repository,
      UserRegisterFormFieldModel userFormFielModel)
      : super(repository, userFormFielModel);
}

abstract class _SignUpThreeControllerBase with Store, MapFailureMessage {
  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _SignUpThreeControllerBase(this.repository, this._userRegisterModel);

  @observable
  ObservableFuture<Either<Failure, SessionEntity>> _progress;

  @observable
  String warningEmail = '';

  @observable
  String warningPassword = '';

  @observable
  String errorMessage = '';

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setEmail(String email) {
    _userRegisterModel.emailAddress = EmailAddress(email);

    warningEmail =
        email.length == 0 ? '' : _userRegisterModel.validateEmailAddress;
  }

  @action
  void setPassword(String password) {
    _userRegisterModel.password = Password(password);

    warningPassword =
        password.length == 0 ? '' : _userRegisterModel.validatePassword;
  }

  @action
  Future<void> registerUserPress() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.signup(
        emailAddress: _userRegisterModel.emailAddress,
        password: _userRegisterModel.password,
        cep: _userRegisterModel.cep,
        cpf: _userRegisterModel.cpf,
        fullname: _userRegisterModel.fullname,
        socialName: _userRegisterModel.socialName,
        nickName: _userRegisterModel.nickname,
        birthday: _userRegisterModel.birthday,
        genre: _userRegisterModel.genre,
        race: _userRegisterModel.race,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) => _forwardToLogged(),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateEmailAddress.isNotEmpty) {
      isValid = false;
      warningEmail = _userRegisterModel.validateEmailAddress;
    }

    if (_userRegisterModel.validatePassword.isNotEmpty) {
      isValid = false;
      warningPassword = _userRegisterModel.validatePassword;
    }

    return isValid;
  }

  _forwardToLogged() {
    Modular.to.pushReplacementNamed('/');
  }
}
