import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/token.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';


class ChangePasswordController extends GetxController {

  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();

  TextEditingController passCnt = TextEditingController();
  TextEditingController confirmPassCnt = TextEditingController();
  TextEditingController code = TextEditingController();

  LoginRepository repository = LoginRepository();
  
  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    super.onReady();
  }

  ChangePasswordController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.20).floor();
    sectionHeight = (deviceHeight * 0.8).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  void ChangePasswordRequest(){
    /**
     * application logic:
     * 1. Form fields not empty
     * 2. Password fields with equal values
     * 3. The server is requested to change the password, depending on the response, a success or failure message is displayed.
     */
    //? 1
    if (code.text.isEmpty || passCnt.text.isEmpty || confirmPassCnt.text.isEmpty){
      EasyLoading.showError('Complete los campos para continuar');
      return;
    }

    //? 2
    if(passCnt.text!=confirmPassCnt.text){
      EasyLoading.showError('Contraseñas distintas');
      return;
    }

    //? 3
    invoqueRepository();

  }


  invoqueRepository() async{
    final userId = box.read('token');

    final body = await repository.patchChangePassword(userId: userId, code: code.text, password: passCnt.text);

    //error handler
    if (body is ErrorHandler) {
      if (body.code == 204){
        Get.close(1);
        EasyLoading.showSuccess("Contraseña actualizada");
      }
      else{
        EasyLoading.showError(body.message);
      }
    }else{
      EasyLoading.showError("Server error");
    }
    
  }

  ResendCode() async{
    final userId = box.read('token');
    print(userId);
    final body = await repository.postChangePassword(userId: userId);

    //error handler
    if (body is ErrorHandler) {
      
      EasyLoading.showError(body.message);
    }
    else if(body is Token){
      //* Save token
      _saveToken(body);
      EasyLoading.showSuccess('Your code has been send');
      
    }else{
      EasyLoading.showError("Server error");
    }
    
  }
  void _saveToken(Token token) {
    box.write('token', token.userId);
  }
}