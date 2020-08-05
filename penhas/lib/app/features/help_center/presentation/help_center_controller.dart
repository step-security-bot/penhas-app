import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/help_center_state.dart';

part 'help_center_controller.g.dart';

class HelpCenterController extends _HelpCenterControllerBase
    with _$HelpCenterController {
  HelpCenterController({
    @required IGuardianRepository guardianRepository,
    @required ILocationServices locationService,
  }) : super(guardianRepository, locationService);
}

abstract class _HelpCenterControllerBase with Store, MapFailureMessage {
  final IGuardianRepository _guardianRepository;
  final ILocationServices _locationService;

  _HelpCenterControllerBase(this._guardianRepository, this._locationService);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _alertProgress;

  @observable
  HelpCenterState alertState = HelpCenterState.initial();

  @observable
  String errorMessage = '';

  @computed
  PageProgressState get loadState {
    if (_alertProgress == null ||
        _alertProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _alertProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void newGuardian() {
    Modular.to.pushNamed('/mainboard/helpcenter/newGuardian');
  }

  @action
  void guardians() {
    Modular.to.pushNamed('/mainboard/helpcenter/guardians');
  }

  @action
  Future<void> triggerGuardian() async {
    _setErrorMessage('');
    _getCurrentLocatin()
        .then((location) => _triggerGuardian(location))
        .then((value) => alertState = value);
  }

  Future<UserLocationEntity> _getCurrentLocatin() async {
    return _locationService
        .currentLocation()
        .then((v) => v.getOrElse(() => UserLocationEntity()));
  }

  Future<HelpCenterState> _triggerGuardian(UserLocationEntity location) async {
    _alertProgress = ObservableFuture(_guardianRepository.alert(location));
    final result = await _alertProgress;

    return result.fold(
      (failure) => _parseFailure(failure),
      (message) => HelpCenterState.guardianTriggered(
        GuardianAlertMessageAction(message: message.message, onPressed: () {}),
      ),
    );
  }

  HelpCenterState _parseFailure(Failure failure) {
    final state = HelpCenterState.initial();
    if (failure is GuardianAlertGpsFailure) {
      return state;
    }

    _setErrorMessage(mapFailureMessage(failure));
    return state;
  }

  void _setErrorMessage(String message) => errorMessage = message;
}
