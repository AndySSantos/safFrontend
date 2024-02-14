import 'dart:io';
import 'dart:convert';
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

class FaceRegistryController extends GetxController {
  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  final numPhotos = 8;
  String userId = ''; // box.read('token');
  String today = '';

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    Get.reload();
    super.onReady();
  }

  FaceRegistryController(Size sizeMobil) {
    userId = box.read('token');
    DateTime now = DateTime.now();
    int year = now.year;
    String month = MONTHS[now.month-1];
    int day = now.day;
    today='$month $day, $year';
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.3).floor();
    sectionHeight = (deviceHeight * 0.5).floor();
    footerHeight = (deviceHeight * 0.15).floor();
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
    String message = '';
    if (isCameraInitialized) {
      final XFile photo = await cameraController.takePicture();
      photoCount++;

      isCameraInitialized = (photoCount == numPhotos) ? false : true;
      message = (isCameraInitialized)
          ? 'Foto $photoCount tomanda'
          : 'Ya puedes mandar tus fotografias';

      // Obtén los bytes de la foto y agrégala a la lista
      final List<int> photoData = await photo.readAsBytes();
      photoDataList.add(photoData);
      //EasyLoading.showInfo("Foto $photoCount tomada");
      EasyLoading.showInfo(message);
    }
  }

  /**
   * Nueva implementacion sugerida por chat-GPT
   */

  Future<String> createImageFolder() async {
    final directory = await getExternalStorageDirectory();
    final folderPath = '${directory!.path}/$userId';

    if (await Directory(folderPath).exists()) {
      // Eliminar el directorio si ya existe
      await Directory(folderPath).delete(recursive: true);
    }

    // Crear el directorio nuevamente
    await Directory(folderPath).create(recursive: true);

    return folderPath;
  }

  Future<void> saveImages(
      List<List<int>> photoDataList, String folderPath) async {
    for (int i = 0; i < photoDataList.length; i++) {
      final filePath = '$folderPath/image_$i.jpg';
      await File(filePath).writeAsBytes(photoDataList[i]);
    }
  }

  Future<void> compressAndSendImages(
      String folderPath, String serverEndpoint) async {
    // Comprimir el folder
    String folder = folderPath.replaceAll('/$userId', '');
    print('Folder path: $folderPath');
    print('Folder : $folder');
    final compressedFilePath = '$folder/$userId.zip';
    await zipDirectory(folderPath, compressedFilePath);
    // Enviar al servidor

    sendToServer(serverEndpoint, compressedFilePath);
  }

  void submitPhotos() async {
    //? 1- save photos in folder iif photos contains numPhotos or more
    if (photoDataList.isEmpty || photoCount < numPhotos) {
      EasyLoading.showError('Necesita tomar $numPhotos fotos');
      return;
    }
    String folder = await createImageFolder();
    await saveImages(photoDataList, folder);
    //? 2- save folder photos in zip or tar and send zip to server
    String server =
        'https://6h53zhw9-8000.usw3.devtunnels.ms'; //'http://10.0.2.2:8000';
    compressAndSendImages(folder, '$SERVER/users/$userId/upload_file');
    //compressAndSendImages(folder, '$server/upload-zip');
    //? 3- Send zip to server fastAPI
  }

  void cancelProcess() {
    photoDataList.clear();
    EasyLoading.showInfo('Proceso cancelado');
    Get.close(1);
  }

  Future<void> zipDirectory(String sourceDirName, String zipFileName) async {
    final sourceDir = Directory(sourceDirName);
    final files = [
      File(sourceDir.path + "/image_0.jpg"),
      File(sourceDir.path + "/image_1.jpg"),
      File(sourceDir.path + "/image_2.jpg"),
      File(sourceDir.path + "/image_3.jpg"),
      File(sourceDir.path + "/image_4.jpg"),
      File(sourceDir.path + "/image_5.jpg"),
      File(sourceDir.path + "/image_6.jpg"),
      File(sourceDir.path + "/image_7.jpg"),

    ];
    final zipFile = File(zipFileName);
    try {
      await ZipFile.createFromFiles(
          sourceDir: sourceDir, files: files, zipFile: zipFile);
      print('Listo');
    } catch (e) {
      print('Error $e');
    }
  }

  Future<void> sendToServer(
      String serverEndpoint, String compressedFilePath) async {
    conect.Dio dio = conect.Dio();

    try {
      File compressedFile = File(compressedFilePath);
      int fileSize = await compressedFile.length();
      //fileSize += 2000;

      conect.FormData formData = conect.FormData.fromMap({
        'file': await conect.MultipartFile.fromFile(
          compressedFilePath,
          //filename: 'archivo.zip', // Cambia esto según tu necesidad
        ),
      });

      conect.Response response = await dio.post(
        serverEndpoint,
        data: formData,
        options: conect.Options(
          contentType: 'multipart/form-data',
          headers: {'Content-Length': '$fileSize'},
          // Puedes añadir más opciones según tus necesidades
        ),
      );
      print('filesize: $fileSize');
      print('Solicitud exitosa: ${response.data}');

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
          responseData.substring(messageIndex + 10, codeIndex-1);

      print('Code: $codeValue');
      print('Message: $messageValue');

      if (codeValue=='201') {
        EasyLoading.showInfo('Fotos cargadas, acceso facial en 12 Hrs',duration: Duration(seconds: 5));
        Get.close(1);
      } else {
        EasyLoading.showInfo(messageValue);
        Get.close(1);
      }
    } catch (e) {
      print('Error inesperado durante la solicitud: $e');
    }
  }
}
