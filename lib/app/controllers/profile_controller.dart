import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/user/profile.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';


class ProfileController extends GetxController {
  // Obtener la altura y el ancho del dispositivo
  final box = GetStorage();
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  String profileResum = '';
  String name = '', email = '', lastfaceUpdate = '';
  TextEditingController userCnt = TextEditingController();
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passCnt = TextEditingController();
  TextEditingController newPassCnt = TextEditingController();
  TextEditingController confirmNewPassCnt = TextEditingController();
  LoginRepository repository = LoginRepository();

  
  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    //super.onReady();
  }
  
  ProfileController(Size sizeMobil) {
    name = box.read('user');
    email = box.read('email');
    lastfaceUpdate = box.read('lastUpgradeFace');
    
    profileResum = 'User Information: \n -User: $name \n -Email:\n $email \n -Last update face: $lastfaceUpdate\n';
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.25).floor();
    sectionHeight = (deviceHeight * 0.62).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }


  actionDeleteAccount(){
    EasyLoading.showInfo('Se eliminara su cuenta');
  }

  actionSaveChanges(){
    if (formFieldsValidation()){
      bool condition = (userCnt.text+emailCnt.text+newPassCnt.text+confirmNewPassCnt.text).trim().isEmpty;
      if (!condition) {
        invoqueRepository();
        Get.close(1);
        return;
      }
      
      EasyLoading.showInfo('Guardando cambios');
      //Get.toNamed(Routes.HOME);
      Get.close(1);
    }
  }

  bool formFieldsValidation(){
    /**
     * Application logic:
     *  1.- If any form field (Not the password field) contains something, then the password field must contain the password.
     *  2.- If the email field contains something, it is verified that it is a UAM's own email.
     *  3.- If the new password field contains something, this content must be the same as the one in the password confirmation.
     *  4.- if no field of the form contains any data, return to the HOME window, otherwise validate points: 1-3.
     */
    //bool response = true;
    //? 1
    bool condition = (userCnt.text+emailCnt.text+newPassCnt.text+confirmNewPassCnt.text).trim().isEmpty;
    if (!condition && passCnt.text.isEmpty) {
      EasyLoading.showError('Ingresa la contraseña para continuar');
      return false;
    }
    //? 2
    condition = !emailCnt.text.isEmail || !EMAIL_REGEX.hasMatch(emailCnt.text );
    if (!emailCnt.text.isEmpty && condition){
      EasyLoading.showError('Ingresa un correo proporcionado por UAM');
      return false;
    }
    //? 3
    condition = newPassCnt.text != confirmNewPassCnt.text;
    if ( (!newPassCnt.text.isEmpty || !confirmNewPassCnt.text.isEmpty) && condition){
      EasyLoading.showError('No coinciden los valores de nueva contraseña');
      return false;
    }

    //? 4
    return true;
  }

  invoqueRepository() async{
    String newUser, newEmail, newPassword;
    final userId = box.read('token');
    newUser = userCnt.text.isEmpty ? "" : userCnt.text ;
    newEmail = emailCnt.text.isEmpty ? "" : emailCnt.text ;
    newPassword = newPassCnt.text.isEmpty ? "" : newPassCnt.text ;
    final body = await repository.putUserInfo(userId: userId, currentPassword: passCnt.text, newUser: newUser, newPassword: newPassword, newEmail: newEmail);
    //print(body);

    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
    }
    else if(body is Profile){
      //print(body.token);
      EasyLoading.showSuccess('Changes saved');
      /*box.remove('user');
      box.remove('email');
      box.remove('lastUpgradeFace');
      box.erase();
      Get.toNamed(Routes.HOME);*/
    }
    
  }
}