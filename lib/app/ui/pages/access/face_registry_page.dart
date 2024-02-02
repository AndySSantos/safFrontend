import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/face_registry_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class FaceRegistryPage extends GetView<FaceRegistryController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('FaceRegistryPage')),

      body: SafeArea(
        child: GetBuilder<FaceRegistryController>(
          init: FaceRegistryController(screenSize),
          builder: (faceRegistryCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //* Header
                  Container(
                    padding: const EdgeInsets.all(5),
                    constraints: BoxConstraints.expand(
                        height: faceRegistryCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * Date
                        const Text(
                          'Date today',
                          style: TextStyle(
                            color: C_DATE,
                          ),
                        ),
                        // * avatar
                        Container(
                          //padding: const EdgeInsets.all(10),
                          //color: C_DATE,
                          constraints: BoxConstraints.expand(
                              height: faceRegistryCtrl.headerHeight*0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Process: \n 1.- Uncover the face \n 2.- Place the device in front of your face.\n 3.- When you are ready, click on the preview \n region of the camera to take a picture. \n 4.- Take 10 to 15 pictures of your face. \n 5.- Click the "Send" button once \n you have taken all 15 pictures.\n Remember that you can cancel this process and try again later, \n also if you do not take at least 10 photos you will \n not be allowed to send the photos \n you have taken.',
                                  style: TextStyle(color: PRIMARY, fontSize: P1),
                                ),
                
                              ),
                              //Text('Avatar')
                              SizedBox(
                                child: Image.asset('assets/images/person2.png'),
                                
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  //*Section
                  Container(
                    constraints: BoxConstraints.expand(
                        height: faceRegistryCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: GestureDetector(
                      onTap: () {
                        faceRegistryCtrl.takePhoto();
                      },
                      child: Center(
                        child: faceRegistryCtrl.isCameraInitialized
                            ? CameraPreview(faceRegistryCtrl.cameraController)
                            : Text("Inicializando cámara..."),
                      ),
                    ),
                  ),
                  //*Footer
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      //color: ACC_SUCCESFULL,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Button CANCEL PROCESS
                          TextButton(
                            onPressed: () {
                              faceRegistryCtrl.cancelProcess();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ACC_DENIED),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: UNNOTICED,
                                fontSize: H4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Button SUBMIT PHOTOS
                          TextButton(
                            onPressed: () {
                              faceRegistryCtrl.submitPhotos();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(SECONDARY),
                            ),
                            child: const Text(
                              'Send photos',
                              style: TextStyle(
                                color: NORMAL,
                                fontSize: H4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: BACKGROUND,
    );
  }
}
