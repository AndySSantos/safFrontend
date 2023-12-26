import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/token.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';

class LoginController extends GetxController {

  TextEditingController emailCnt = TextEditingController();
  TextEditingController passCnt = TextEditingController();
  LoginRepository repository = LoginRepository();

  RegExp emailRegex = RegExp(r'^[\w-\.]+@(izt|titlani|xanum)\.uam\.mx$');


  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    super.onReady();
  }

  validateFields(){
    /**
     * Application logic:
     *  1.- Non-empty fields
     *  2.- Is the userEmail field an email?
     *  3.- Is the userEmail a UAM domain?

     */

    //1.
    if (emailCnt.text.isEmpty || passCnt.text.isEmpty)  {
      EasyLoading.showError('Please fill in both fields to continue');
    }
    //2. 3.
    else if (!emailCnt.text.isEmail || !emailRegex.hasMatch(emailCnt.text)) {
      EasyLoading.showError('Please enter an email validated by UAM');
    }
    else{
      invoqueRepository();
      //Get.toNamed(Routes.HOME);
    }
  }

  changeToSignin(){
    Get.toNamed(Routes.SIGNIN);
  }

  invoqueRepository() async{
    final body = await repository.postLogin(email: emailCnt.text , password: passCnt.text);
    print(body);

    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
    }
    else if(body is Token){
      print(body.token);
      EasyLoading.showSuccess("Welcome");
      Get.toNamed(Routes.HOME);
    }
    


  }

}