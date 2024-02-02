import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/routes/pages.dart';
import 'dart:io'; // Agrega esta línea para trabajar con archivos
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter_archive/flutter_archive.dart' as zip;
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FaceRegistryController extends GetxController {
  final box = GetStorage();
  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  final userId = '65aa0bdcdc274d7b99649065'; // box.read('token');

  @override
  void onReady() {
    //fetchApi();
    //invoqueRepository();
    Get.reload();
    super.onReady();
  }

  FaceRegistryController(Size sizeMobil) {
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
    if (isCameraInitialized) {
      final XFile photo = await cameraController.takePicture();
      photoCount++;

      if (photoCount == 5) {
        //await cameraController.dispose();
        isCameraInitialized = false;
        EasyLoading.showSuccess("Ya puedes mandar tus fotos");

        //savePhotosToZip();
        // Realizar la solicitud HTTP a FastAPI
        //await submitPhotosToFastAPI();
      }

      // Obtén los bytes de la foto y agrégala a la lista
      final List<int> photoData = await photo.readAsBytes();
      photoDataList.add(photoData);
      EasyLoading.showInfo("Foto $photoCount tomada");
    }
  }

  Future<void> savePhotosToZip() async {
    if (photoDataList.isEmpty) {
      // No hay fotos para empaquetar
      return;
    }

    final Archive archive = Archive();

    for (int i = 0; i < photoDataList.length; i++) {
      final List<int> photoData = photoDataList[i];
      final String fileName = 'photo_$i.jpg';

      archive.addFile(ArchiveFile(fileName, photoData.length, photoData));
    }

    // Obten la ruta del directorio de documentos
    final directory = await getApplicationDocumentsDirectory();

    // Construye la ruta completa para el archivo zip
    final String zipPath = directory.path + '/photos.tar';

    final File file = File(zipPath);

    try {
      await file.writeAsBytes(TarEncoder().encode(archive));
      print('Archivo zip guardado en: $zipPath');
    } catch (e) {
      print('Error al guardar el archivo zip: $e');
    }
  }

  Future<void> submitPhotosToFastAPI() async {
    if (photoDataList.isEmpty) {
      // No hay fotos para enviar
      return;
    }
    final userId = '65aa0bdcdc274d7b99649065'; // box.read('token');
    try {
      // Crear una solicitud multipart para enviar archivos
      var request = http.MultipartRequest(
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

  /**
   * Nueva implementacion sugerida por chat-GPT
   */

  Future<String> createImageFolder() async {
    final directory =
        await getExternalStorageDirectory(); //await getApplicationDocumentsDirectory();
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
    //await Process.run('zip', ['-r', compressedFilePath, folderPath]);
    await zipDirectory(folderPath, compressedFilePath);

    // Leer el archivo comprimido
    final compressedFile = File(compressedFilePath);
    List<int> compressedBytes = await compressedFile.readAsBytes();

    // Enviar al servidor
    //await sendToServer(compressedBytes, serverEndpoint);

    var request = http.MultipartRequest('POST', Uri.parse(serverEndpoint))
      ..files
          .add(await http.MultipartFile.fromPath('file', compressedFilePath));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Solicitud exitosa: ${await response.stream.bytesToString()}');
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  }

  Future<void> sendToServer(
      List<int> compressedBytes, String serverEndpoint) async {
    final response = await http.post(
      Uri.parse(serverEndpoint),
      headers: {'Content-Type': 'application/zip'},
      body: compressedBytes,
    );

    print('Server Response: ${response.statusCode}');
    print('Server Body: ${response.body}');
  }

  void submitPhotos() async {
    //? 1- save photos in folder iif photos contains 5 or more
    if (photoDataList.isEmpty || photoCount < 5) {
      EasyLoading.showError('Necesita tomar almenos 5 fotos');
      return;
    }
    String folder = await createImageFolder();
    await saveImages(photoDataList, folder);
    //? 2- save folder photos in zip or tar and send zip to server
    String server = 'http://10.0.2.2:8000';
    compressAndSendImages(folder, '$server/upload_file');
    //? 3- Send zip to server fastAPI
  }

  void cancelProcess() {
    photoDataList.clear();
    EasyLoading.showInfo('Proceso cancelado');
    Get.close(1);
  }

  Future<void> zipDirectory(String sourceDirName, String zipFileName) async {
    /*var encoder = ZipFileEncoder();
    //await encoder.zipDirectoryAsync(Directory(sourceDir), filename: zipFile);
    // Manually create a zip of a directory and individual files.
    encoder.create(zipFile);
    encoder.addDirectory(Directory(sourceDir));
    /*for (var i = 0; i < 5; i++) {
      encoder.addFile(File('$sourceDir/image_$i.jpg'));
    }*/
    encoder.close();
    */
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
      zip.ZipFile.createFromFiles(
          sourceDir: sourceDir, files: files, zipFile: zipFile);
          print('Listo');
    } catch (e) {
      print('Error $e');
    }
  }
}
