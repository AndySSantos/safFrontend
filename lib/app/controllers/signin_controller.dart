import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/token.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

class SigninController extends GetxController {

   // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();


  TextEditingController emailCnt = TextEditingController();
  TextEditingController passCnt = TextEditingController();
  TextEditingController confirmPassCnt = TextEditingController();
  LoginRepository repository = LoginRepository();

  SigninController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.3).floor();
    sectionHeight = (deviceHeight * 0.6).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }
  /// ?Validate fields from form signin
  /// Application logic:
  /// 1. The fields of the form must not be empty.
  /// 2. The email field is an email and is a domain managed by UAM.
  /// 3. The password and confirm password fields have the same value.
  formFieldsValidation(){
    if (emailCnt.text.isEmpty || passCnt.text.isEmpty || confirmPassCnt.text.isEmpty) {
      EasyLoading.showError('Please fill in both fields to continue');
    }
    else if (!emailCnt.text.isEmail || !EMAIL_REGEX.hasMatch(emailCnt.text)) {
      EasyLoading.showError('Please enter an email validated by UAM');
    }
    else if (passCnt.text != confirmPassCnt.text) {
      EasyLoading.showError('Passwords entered not the same');
    }
    else{
      //EasyLoading.showSuccess('Account created');
      //Get.toNamed(Routes.CHECK);
      invoqueRepository();
    }
  }
  returnLoginPage(){
    Get.toNamed(Routes.LOGIN);
  }

  invoqueRepository() async{
    final body = await repository.postSignin(email: emailCnt.text , password: passCnt.text);
    print(body);

    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
    }
    else if(body is Token){
      print(body.token);
      EasyLoading.showSuccess('Account created');
      Get.toNamed(Routes.CHECK);
    }
    
  }

}