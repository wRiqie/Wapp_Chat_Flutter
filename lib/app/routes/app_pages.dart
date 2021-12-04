import 'package:get/get.dart';
import 'package:wapp_chat/app/modules/about_user/about_user_binding.dart';
import 'package:wapp_chat/app/modules/about_user/about_user_page.dart';
import 'package:wapp_chat/app/modules/config/config_binding.dart';
import 'package:wapp_chat/app/modules/config/config_page.dart';
import 'package:wapp_chat/app/modules/profile/profile_binding.dart';
import 'package:wapp_chat/app/modules/profile/profile_page.dart';
import 'package:wapp_chat/app/modules/signin/signin_binding.dart';
import 'package:wapp_chat/app/modules/signin/signin_page.dart';
import 'package:wapp_chat/app/modules/signup/signup_binding.dart';
import 'package:wapp_chat/app/modules/signup/signup_page.dart';
import 'package:wapp_chat/app/modules/tabs/tabs_binding.dart';
import 'package:wapp_chat/app/modules/tabs/tabs_page.dart';
import 'package:wapp_chat/app/modules/welcome/welcome_binding.dart';
import 'package:wapp_chat/app/modules/welcome/welcome_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.CADASTRO,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => TabsPage(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.CONFIG,
      page: () => ConfigPage(),
      binding: ConfigBinding(),
    ),
    GetPage(
      name: Routes.ABOUTUSER,
      page: () => AboutUserPage(),
      binding: AboutUserBinding(),
    ),
  ];
}
