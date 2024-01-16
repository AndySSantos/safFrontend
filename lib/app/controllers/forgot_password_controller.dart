import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/token.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';


class ForgotPasswordController extends GetxController {

  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();

  TextEditingController emailCnt = TextEditingController();
  LoginRepository repository = LoginRepository();

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    super.onReady();
  }

  ForgotPasswordController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.35).floor();
    sectionHeight = (deviceHeight * 0.55).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  void ForgotRequest(){
    /**
     * application logic:
     * 1. The email field is not empty
     * 2. There is an email in the field
     * 3. If there is a response from the server, we change the screen to "Change password".
     */

    //? 1
    if (emailCnt.text.isEmpty) {

     EasyLoading.showError("Capture los campos para continuar");
     return;
    }

    //? 2
    //* Condition: Is a email and is a email asociated to UAM
    bool condition = emailCnt.text.isEmail && EMAIL_REGEX.hasMatch(emailCnt.text);
    if (!condition){
      EasyLoading.showError("Ingrese un correo asociado a UAM");
      return;
    }
    
    //? 3
    //* Conect server and wait response
    invoqueRepository();
  }

  invoqueRepository() async{
    final body = await repository.postForgotPassword(email: emailCnt.text);

    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
    }
    else if(body is Token){
      //* Save token
      _saveToken(body);
      //* Change page 
      Get.close(1);
      Get.toNamed(Routes.CHANGE_PASSWORD);
    }
    

  }

  void _saveToken(Token token) {
    box.write('token', token.userId);
  }
  CancelProcess(){
    Get.close(1);
  }

}