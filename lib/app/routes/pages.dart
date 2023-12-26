import 'package:get/get.dart';
import 'package:safuami/app/ui/pages/home/home_page.dart';
import 'package:safuami/app/ui/pages/login/login_page.dart';
import 'package:safuami/app/ui/pages/profile/profile_page.dart';
import 'package:safuami/app/ui/pages/signin/check_page.dart';
import 'package:safuami/app/ui/pages/signin/signin_page.dart';

import 'package:safuami/main.dart';
part './routes.dart';

abstract class AppPages {

  static final pages = [
    GetPage(name: Routes.LOGIN, page:()=> LoginPage(),),
    GetPage(name: Routes.HOME, page:()=> HomePage(),),
    GetPage(name: Routes.SIGNIN, page:()=> SigninPage(),),
    GetPage(name: Routes.CHECK, page:()=> CheckPage(),),
    GetPage(name: Routes.PROFILE, page:()=> ProfilePage(),),

  ];
}