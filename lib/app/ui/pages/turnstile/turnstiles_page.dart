import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/turnstiles_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnstilesPage extends GetView<TurnstilesController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text('HomePage')),

      body: SafeArea(
        child: GetBuilder<TurnstilesController>(
          init: TurnstilesController(screenSize),
          builder: (turnstilesCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    constraints: BoxConstraints.expand(
                        height: turnstilesCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //*buttom return login
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.close_page();
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
                        height: turnstilesCtrl.sectionHeight.toDouble()),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: UNNOTICED,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //LABELS
                        const Text(
                          'Turnstiles enabled.',
                          style: TextStyle(
                            fontSize: H1,
                            fontWeight: FontWeight.bold,
                            color: NORMAL,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                        //? BOTONES

                        //* Puerta 4 
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.info_turnstile('65a9f3e8dc274d7b99649060');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.share_location, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el icono y el texto
                              Text(
                                'Puerta 4',
                                style: TextStyle(
                                  // Estilos del texto del botón
                                  fontSize: P1,
                                  color: UNNOTICED,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15.0), // Define el padding
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
                        ),
                        
                        SizedBox(
                          height: 10,
                        ),
                        //* Puerta 2
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.info_turnstile('65a9f451dc274d7b99649061');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.share_location, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el icono y el texto
                              Text(
                                'Puerta 2',
                                style: TextStyle(
                                  // Estilos del texto del botón
                                  fontSize: P1,
                                  color: UNNOTICED,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15.0), // Define el padding
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //* Puerta 5
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.info_turnstile('65a9f5a0dc274d7b99649063');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.share_location, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el icono y el texto
                              Text(
                                'Puerta 5',
                                style: TextStyle(
                                  // Estilos del texto del botón
                                  fontSize: P1,
                                  color: UNNOTICED,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15.0), // Define el padding
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //* Puerta 6
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.info_turnstile('65a9f619dc274d7b99649064');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.share_location, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el icono y el texto
                              Text(
                                'Puerta 6',
                                style: TextStyle(
                                  // Estilos del texto del botón
                                  fontSize: P1,
                                  color: UNNOTICED,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15.0), // Define el padding
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //* Puerta principal
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            turnstilesCtrl.info_turnstile('65a9f4dcdc274d7b99649062');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.share_location, // Icono predefinido de Flutter
                                color: UNNOTICED, // Color del icono
                                size: SIZED_ICON_LARGE, // Tamaño del icono
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el icono y el texto
                              Text(
                                'Puerta Principal',
                                style: TextStyle(
                                  // Estilos del texto del botón
                                  fontSize: P1,
                                  color: UNNOTICED,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15.0), // Define el padding
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(FREGISTRY),
                          ),
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
