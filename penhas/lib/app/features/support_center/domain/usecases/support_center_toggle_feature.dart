import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class SupportCenterToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'pontos_de_apoio';

  Future<bool> get isEnabled => _isEnabled();

  SupportCenterToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(
        name: SupportCenterToggleFeature.featureCode);
    return module != null;
  }
}
