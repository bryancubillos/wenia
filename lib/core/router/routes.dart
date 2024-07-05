import 'package:flutter/material.dart';

import 'package:wenia/features/common/menu/presentation/menu_page.dart';
import 'package:wenia/features/common/welcome/presentation/welcome_page.dart';
import 'package:wenia/features/security/account/presentation/account_page.dart';
import 'package:wenia/features/security/change_password/presentation/change_password_page.dart';
import 'package:wenia/features/security/login/presentation/security_login_page.dart';
import 'package:wenia/features/security/new_account/presentation/new_account_page.dart';
import 'package:wenia/features/security/security/presentation/security_page.dart';

class Routes {

  // Wenia app routes

  // Security
  static const String login = '/login';
  static const String changePassword = '/changePassword';
  static const String security = '/security';

  // Account
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String account = '/account';

  // Common
  static const String welcome = '/welcome';
  static const String menu = '/menu';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {
      // [Wenia Apps]

      // Security
      login: (context) => const SecurityLoginPage(),
      changePassword: (context) => const ChangePasswordPage(),
      
      // Account
      register: (context) => const NewAccountPage(),
      security: (context) => const SecurityPage(),
      account: (context) => const AccountPage(),
      
      // Settings
      profile: (context) => Container(),
      settings: (context) => Container(),

      // Common
      menu: (context) => const MenuPage(),
      welcome: (context) => const WelcomePage()
    };

    return routes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case menu:
        return MaterialPageRoute(builder: (context) => const MenuPage());
      case login:
        return MaterialPageRoute(builder: (context) => const SecurityLoginPage());
      case security:
        return MaterialPageRoute(builder: (context) => const SecurityPage());
      case account:
        return MaterialPageRoute(builder: (context) => const AccountPage());
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }

}