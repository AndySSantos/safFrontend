import 'package:get/get.dart';
import 'package:safuami/app/ui/pages/access/face_registry_page.dart';
import 'package:safuami/app/ui/pages/home/home_page.dart';
import 'package:safuami/app/ui/pages/login/change_password_page.dart';
import 'package:safuami/app/ui/pages/login/forgot_password_page.dart';
import 'package:safuami/app/ui/pages/login/login_page.dart';
import 'package:safuami/app/ui/pages/profile/profile_page.dart';
import 'package:safuami/app/ui/pages/signin/check_page.dart';
import 'package:safuami/app/ui/pages/signin/signin_page.dart';
import 'package:safuami/app/ui/pages/turnstile/turnstiles_page.dart';
import 'package:safuami/app/ui/pages/turnstile/info_turnstile_page.dart';


import 'package:safuami/main.dart';
part './routes.dart';

abstract class AppPages {

  static final pages = [
    GetPage(name: Routes.LOGIN, page:()=> LoginPage(),),
    GetPage(name: Routes.HOME, page:()=> HomePage(),),
    GetPage(name: Routes.SIGNIN, page:()=> SigninPage(),),
    GetPage(name: Routes.CHECK, page:()=> CheckPage(),),
    GetPage(name: Routes.PROFILE, page:()=> ProfilePage(),),
    GetPage(name: Routes.FORGOT_PASSWORD, page:()=> ForgotPasswordPage(),),
    GetPage(name: Routes.CHANGE_PASSWORD, page:()=> ChangePasswordPage(),),
    GetPage(name: Routes.INFO_TURNSTILE, page:()=> InfoTurnstilePage(),),
    GetPage(name: Routes.TURNSTILES, page:()=> TurnstilesPage(),),
    GetPage(name: Routes.FACE_REGISTRY, page:()=> FaceRegistryPage(),),

  ];
}