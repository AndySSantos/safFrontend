import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:safuami/app/routes/pages.dart';


class CheckController extends GetxController {
  TextEditingController code = TextEditingController();

  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();

  CheckController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.5).floor();
    sectionHeight = (deviceHeight * 0.4).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  /// ?Application logic
  /// 1.- The field is not sent empty.
  /// 2.- The length of the code is fixed to 8 characters.
  validateCodeAccount(){
    if (code.text.isEmpty) {
      EasyLoading.showError('Please enter the code');
    }
    else if ((code.text.length >0 && code.text.length< 8) || code.text.length > 8 ){
      EasyLoading.showInfo('The code is 8 characters long');
    }else{
      EasyLoading.showSuccess('Account validated');
      Get.toNamed(Routes.HOME);
    }
  }

  sendCode(){

    EasyLoading.showSuccess('Your code has been resent');

  }

}