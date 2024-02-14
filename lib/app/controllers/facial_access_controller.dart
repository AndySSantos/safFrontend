import 'dart:io';
import 'dart:math';
//import 'package:archive/archive_io.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as conect;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';
import 'package:uuid/uuid.dart';

class FacialAccessController extends GetxController {
  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  final numPhotos = 1;
  String userId = ''; // box.read('token');
  String today = '';
  var TURNSTILES = [];

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    Get.reload();
    super.onReady();
  }

  FacialAccessController(Size sizeMobil) {
    TURNSTILES = [
      '65a9f3e8dc274d7b99649060',
      '65a9f451dc274d7b99649061',
      '65a9f5a0dc274d7b99649063',
      '65a9f619dc274d7b99649064',
      '65a9f4dcdc274d7b99649062'
    ];
    userId =box.read('token');
    DateTime now = DateTime.now();
    int year = now.year;
    String month = MONTHS[now.month - 1];
    int day = now.day;
    today = '$month $day, $year';
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.35).floor();
    sectionHeight = (deviceHeight * 0.55).floor();
    footerHeight = (deviceHeight * 0.1).floor();
  }

  late CameraController cameraController;
  bool isCameraInitialized = false;
  int photoCount = 0;
  List<List<int>> photoDataList = [];

  // ... Otras funciones

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);

    await cameraController.initialize();
    isCameraInitialized = true;
    update();
  }

  Future<void> takePhoto() async {
    if (isCameraInitialized) {
      final XFile photo = await cameraController.takePicture();
      photoCount++;

      isCameraInitialized = (photoCount == numPhotos) ? false : true;

      // Obtén los bytes de la foto y agrégala a la lista
      final List<int> photoData = await photo.readAsBytes();
      photoDataList.add(photoData);

      EasyLoading.showInfo('Analizando foto');

      // Obtener el elemento aleatorio de la lista
      // Crear una instancia de Random
      Random random = Random();

      // Obtener un índice aleatorio dentro del rango de la lista
      int indiceAleatorio = random.nextInt(TURNSTILES.length);
      var turnstileId = TURNSTILES[indiceAleatorio];

      // Envía la foto al servidor
      await sendPhotoToServer(photoData, '$SERVER/access/users/$userId/turnstiles/$turnstileId');
    }
  }

  void cancelProcess() {
    photoDataList.clear();
    EasyLoading.showInfo('Proceso cancelado');
    Get.close(1);
  }

  Future<void> sendPhotoToServer(
      List<int> photoData, String serverEndpoint) async {
    var uuid = Uuid();

    conect.Dio dio = conect.Dio();

    try {
      conect.FormData formData = conect.FormData.fromMap({
        'file': conect.MultipartFile.fromBytes(
          photoData,
          filename: '${uuid.v4()}.jpg', // Cambia esto según tu necesidad
        ),
      });

      conect.Response response = await dio.post(
        serverEndpoint,
        data: formData,
        options: conect.Options(
          contentType: 'multipart/form-data',
        ),
      );

      print("Respuesta del servidor: ${response.data}");
      String responseData = response.data.toString();

// Buscar la posición de 'code' en la cadena
      int codeIndex = responseData.indexOf('code');

// Obtener el valor de 'code' a partir de la posición encontrada
      String codeValue = responseData.substring(codeIndex + 6,
          codeIndex + 9); // Suponiendo que el valor de code es de 3 dígitos

// Buscar la posición de 'message' en la cadena
      int messageIndex = responseData.indexOf('message');

// Obtener el valor de 'message' a partir de la posición encontrada
      String messageValue =
          responseData.substring(messageIndex + 10, codeIndex - 1);

      print('Code: $codeValue');
      print('Message: $messageValue');

      if (codeValue == '201') {
        EasyLoading.showInfo(messageValue,
            duration: Duration(seconds: 5));
        Get.close(1);
      } else if (codeValue == '401') {
        EasyLoading.showInfo(messageValue,
            duration: Duration(seconds: 5));
        Get.close(1);
      }else{
        EasyLoading.showInfo(messageValue);
        Get.close(1);
      }
    } catch (e) {
      print('Error inesperado durante la solicitud: $e');
    }
  }
}
