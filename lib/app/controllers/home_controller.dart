import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:safuami/app/routes/pages.dart';

class HomeController extends GetxController {
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();

  HomeController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.3).floor();
    sectionHeight = (deviceHeight * 0.6).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  openAccountSettings() {
    Get.toNamed(Routes.PROFILE);
  }
  signOut(){
    Get.toNamed(Routes.LOGIN);
  }
}
