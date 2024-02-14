import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/turnstile/turnstile.dart';
import 'package:safuami/app/data/repository/login_repository.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/user/profile.dart';
import 'package:safuami/app/data/repository/turnstile_repository.dart';
import 'package:safuami/app/routes/pages.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  LoginRepository repository = LoginRepository();
  TurnstileRepository turnstileRepository = TurnstileRepository();
  String today = '';

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    Get.reload();
    super.onReady();
  }

  HomeController(Size sizeMobil) {
    DateTime now = DateTime.now();
    int year = now.year;
    String month = MONTHS[now.month-1];
    int day = now.day;
    today='$month $day, $year';
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.25).floor();
    sectionHeight = (deviceHeight * 0.62).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  openAccountSettings() {
    //Get.toNamed(Routes.PROFILE);
    invoqueRepository();
  }
  signOut(){
    box.remove('token');
    Get.toNamed(Routes.LOGIN);
  }

  invoqueRepository() async{
    final userId = box.read('token');
    final body = await repository.getProfileUser(userId: userId);
    //print(body);

    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
      if (body.code == 406){
        Get.toNamed(Routes.CHECK);
      }
      

    }
    else if(body is Profile){
      //print(body.token);
      _saveProfile(body);
      Get.toNamed(Routes.PROFILE);
    }
    
  }


  void _saveProfile(Profile profile) {
    box.write('user', profile.user);
    box.write('email', profile.email);
    //box.write('user', profile.emailVerified);
    box.write('lastUpgradeFace', profile.lastUpgradeFace);
  }

  //////////////////////// Este codigo no ira aqui solo se hacen pruebas
  
  void InfoTurnstiles(){
    //invoqueTurnstileRepo();
    Get.toNamed(Routes.TURNSTILES);

  }


  invoqueTurnstileRepo() async{
    final String idTurnstile = '65a7fefa186826182a109346';
    final body = await turnstileRepository.getInfoTurnstile(turnstileId: idTurnstile );

    print("Respuesta");
    print(body);
    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);    
    }
    else if(body is Turnstile){
      //print(body.token);
      save_cache(body);

      Get.toNamed(Routes.INFO_TURNSTILE);
    }
  }

  void save_cache(Turnstile info) {
    box.write('door', info.gate);
    box.write('ubication', info.location);
    box.write('urlPhoto', info.urlPhoto);
    box.write('state', info.state);
    
  }

  void upload_photos(){
    Get.toNamed(Routes.FACE_REGISTRY);
  }
  void saf(){
    Get.toNamed(Routes.FACIAL_ACCESS);
  }
}
