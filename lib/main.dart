//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:safuami/app/bindings/login_binding.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/themes/light_theme.dart';

void main() {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.INITIAL,
        theme: appThemeData,
        defaultTransition: Transition.fade,
        initialBinding: LoginBinding(),
        getPages: AppPages.pages,
        builder: (context,widget){
          widget=EasyLoading.init()(context,widget);

          return widget;
        },
        //home: SplashPage(),
    )
  );
}