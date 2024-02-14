import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/info_turnstile_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoTurnstilePage extends GetView<InfoTurnstileController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text('HomePage')),

      body: SafeArea(
        child: GetBuilder<InfoTurnstileController>(
          init: InfoTurnstileController(screenSize),
          builder: (infoTurnstileCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    constraints: BoxConstraints.expand(
                        height: infoTurnstileCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //*buttom return login
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            infoTurnstileCtrl.close_page();
                          },
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons
                                    .arrow_circle_left_sharp, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              //Text(''),
                            ],
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.bottomLeft,
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
                        ),

                        //*Row images
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Distribuye el espacio entre los widgets
                          children: [
                            //traffic light
                            SizedBox(
                              child: Image.asset('assets/images/semaforo.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //*Section
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints.expand(
                        height: infoTurnstileCtrl.sectionHeight.toDouble()),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: UNNOTICED,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //LABELS
                        const Text(
                          'Info. Torniquete',
                          style: TextStyle(
                            fontSize: H1,
                            fontWeight: FontWeight.bold,
                            color: NORMAL,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //*Row images
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Distribuye el espacio entre los widgets
                          children: [
                            //traffic light
                            SizedBox(
                              child: Image.asset('assets/images/${infoTurnstileCtrl.urlPhoto}'),//'assets/images/puerta4.png'
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        const Text(
                          'Nombre:',
                          style: TextStyle(color: SECONDARY, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          infoTurnstileCtrl.name,
                          style: TextStyle(color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        
                        const Text(
                          'Ubication:',
                          style: TextStyle(color: SECONDARY, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          infoTurnstileCtrl.ubication,
                          style: TextStyle(color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        
                        const Text(
                          'Estado:',
                          style: TextStyle(color: SECONDARY, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          infoTurnstileCtrl.state,
                          style: TextStyle(color: PRIMARY, fontWeight: FontWeight.bold),
                        ),

                        Spacer(),
                        


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Button Login
                            TextButton(
                              onPressed: () {
                                infoTurnstileCtrl.copyInfo();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(SECONDARY),
                              ),
                              child: const Text(
                                'Copy\nUbication',
                                style: TextStyle(
                                  color: UNNOTICED,
                                  fontSize: H5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //*Footer
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints.expand(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //text
                          Text(
                            'safUAMI ',
                            style: TextStyle(color: PRIMARY),
                          ),
                          Text(
                            'v1.01 ',
                            style: TextStyle(color: SECONDARY),
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
