import 'package:flutter_modular/flutter_modular.dart';

import 'user_profile_controller.dart';
import 'user_profile_page.dart';

class UserProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => UserProfileController(
            person: i.args?.data,
            getChatChannelToken: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/profile', child: (_, args) => const UserProfilePage()),
        ChildRoute(
          '/profile_from_feed',
          child: (_, args) => const UserProfilePage(),
          transition: TransitionType.noTransition,
        ),
      ];
}
