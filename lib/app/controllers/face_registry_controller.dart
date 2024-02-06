import 'dart:io';

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

class FaceRegistryController extends GetxController {
  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  final numPhotos = 5;
  String userId = ''; // box.read('token');

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    Get.reload();
    super.onReady();
  }

  FaceRegistryController(Size sizeMobil) {
    userId = '65aa0bdcdc274d7b99649065'; //box.read('token');
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

/*
  Future<void> submitPhotosToFastAPI() async {
    if (photoDataList.isEmpty) {
      // No hay fotos para enviar
      return;
    }
    final userId = '65aa0bdcdc274d7b99649065'; // box.read('token');
    try {
      // Crear una solicitud multipart para enviar archivos
      var request = MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/upload_file'),
      );

      // Agregar cada foto al formulario multipart
      for (int i = 0; i < photoDataList.length; i++) {
        final List<int> photoData = photoDataList[i];
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          photoData,
          filename: 'photo_$i.jpg',
        ));
      }

      // Enviar la solicitud
      var response = await request.send();

      // Manejar la respuesta
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta según tu lógica
        print('Solicitud exitosa: ${await response.stream.bytesToString()}');
        EasyLoading.showSuccess('Fotos correctamente subidas');

        // Luego, puedes manejar la respuesta en tu aplicación según tus necesidades
        //await handleServerResponse(response);
      } else {
        // La solicitud no fue exitosa, manejar errores aquí
        print('Error en la solicitud: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Manejar errores de red u otros errores aquí
      print('Error en la solicitud: $e');
    }
  }
*/

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
    EasyLoading.showInfo('Fotos comprimidas');
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
    //compressAndSendImages(folder, '$server/users/$userId/upload_file');
    compressAndSendImages(folder, '$server/upload-zip');
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
      File(sourceDir.path + "/image_4.jpg")
    ];
    final zipFile = File(zipFileName);
    try {
      ZipFile.createFromFiles(
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
      fileSize+=2000;

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

      print('Solicitud exitosa: ${response.data}');
    }
    catch (e) {
      print('Error inesperado durante la solicitud: $e');
    }
  }
}
