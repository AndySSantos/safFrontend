import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';


class CheckController extends GetxController {
  final box = GetStorage();

  @override
  void onReady() {
    // TODO: implement onReady
    //checkToken();
    invoqueRepository();
    //super.onReady();
  }

  TextEditingController code = TextEditingController();
  LoginRepository repository = LoginRepository();


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
      //EasyLoading.showSuccess('Account validated');
      //Get.toNamed(Routes.HOME);
      //invoqueRepository();
      vereficationCode();
    }
  }

  sendCode(){
    invoqueRepository();

  }

  checkToken(){
    final token = box.read('token');
    print(">>>>Token en sistema: ");
    print(token);
    print("<<<<Token en sistema: ");
  }

  invoqueRepository() async{
    final token = box.read('token');
    final body = await repository.postSendCode(userId: token);
    //print(body);

    //error handler
    if (body is ErrorHandler) {
      if (body.code==204){
        EasyLoading.showSuccess('Your code has been send');
        //EasyLoading.showSuccess('Account validated');
        //Get.toNamed(Routes.HOME);
      }else{
        EasyLoading.showError(body.message);
      }
      
    }
    else{
      EasyLoading.showError('Server error');
    }
    
  }

  vereficationCode() async{
    final token = box.read('token');
    final body = await repository.postVerifyCode(userId: token, code: code.text);
    //print(body);

    //error handler
    if (body is ErrorHandler) {
      if (body.code==204){
        EasyLoading.showSuccess('Account validated');
        Get.toNamed(Routes.HOME);
      }else{
        EasyLoading.showError(body.message);
      }
      
    }
    else{
      EasyLoading.showError('Server error');
    }
    
  }

}