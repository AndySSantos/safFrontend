import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/facial_access_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class FacialAccessPage extends GetView<FacialAccessController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('FaceRegistryPage')),

      body: SafeArea(
        child: GetBuilder<FacialAccessController>(
          init: FacialAccessController(screenSize),
          builder: (facialAccessCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //* Header
                  Container(
                    padding: const EdgeInsets.all(5),
                    constraints: BoxConstraints.expand(
                        height: facialAccessCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * Date
                        Text(
                          facialAccessCtrl.today,
                          style: TextStyle(
                            color: C_DATE,
                          ),
                        ),
                        Text('Request Access', style: TextStyle(color: UNNOTICED, fontSize: H2,fontWeight: FontWeight.bold),),
                        // * avatar
                        Container(
                          //padding: const EdgeInsets.all(10),
                          //color: C_DATE,
                          constraints: BoxConstraints.expand(
                              height: facialAccessCtrl.headerHeight*0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              const SizedBox(
                                child: Text(
                                  'Process: \n 1.- Discover face \n 2.- When you are ready, click on the preview \n region of the camera to take a picture. \n 3.- Wait while your photo is analyzed.',
                                  style: TextStyle(color: PRIMARY),
                                ),
                
                              ),
                              //Text('Avatar')
                              SizedBox(
                                child: Image.asset('assets/images/Yellow.png'),
                                
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
                        height: facialAccessCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: GestureDetector(
                      onTap: () {
                        facialAccessCtrl.takePhoto();
                      },
                      child: Center(
                        child: facialAccessCtrl.isCameraInitialized
                            ? CameraPreview(facialAccessCtrl.cameraController)
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
                              facialAccessCtrl.cancelProcess();
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
