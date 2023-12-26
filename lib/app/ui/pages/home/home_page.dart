import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/home_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';


class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('HomePage')),

      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(screenSize),
          builder: (homeCtrl) {
            return Container(
              constraints: const BoxConstraints.expand(),
              /*child: GetBuilder<HomeController>(
            builder: (homeCtrl) {
              return Column(

              );
            },
          ),*/
              child: Column(children: [
                //* Header
                Container(
                  padding: const EdgeInsets.all(5),
                  constraints:
                      BoxConstraints.expand(height: homeCtrl.headerHeight.toDouble()),
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
                            height: (homeCtrl.headerHeight * 0.9 - homeCtrl.footerHeight * 0.9)
                                .toDouble()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(' '),
                            ),
                            //Text('Avatar')
                            SizedBox(
                              //child: Image.asset('assets/images/person2.png'),
                              child: InkWell(
                                onTap: () {
                                  // Action by pressing the image
                                  //print('The Avatar was pushed');
                                  homeCtrl.openAccountSettings();
                                  // Launch any action here
                                },
                                child: Image.asset('assets/images/person2.png'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // * Text: Welcome
                      const Text(
                        'Welcome',
                        style: TextStyle(color: PRIMARY, fontSize: P1),
                      ),
                      // * Text: User
                      const Text(
                        'User',
                        style: TextStyle(
                            color: UNNOTICED,
                            fontSize: H1,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                //*section
                Container(
                  padding: const EdgeInsets.all(20),
                  constraints:
                      BoxConstraints.expand(height: homeCtrl.sectionHeight.toDouble()),
                  //color: ACC_PROS,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: UNNOTICED,
                  ),
                  //color: ACC_PROS,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: H2,
                        ),
                      ),
                      //buttons Start
                      Container(
                        padding: const EdgeInsets.all(20),
                        //color: ACC_DENIED,
                        constraints:
                            BoxConstraints.expand(height: homeCtrl.sectionHeight / 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Button authentication
                            TextButton(
                              onPressed: () {
                                // Acción al presionar el botón
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons
                                        .schema, // Icono predefinido de Flutter
                                    color: UNNOTICED, // Color del icono
                                    size: SIZED_ICON_LARGE, // Tamaño del icono
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Espacio entre el icono y el texto
                                  Text(
                                    'Authentication',
                                    style: TextStyle(
                                      // Estilos del texto del botón
                                      fontSize: P1,
                                      color: UNNOTICED,
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(15.0), // Define el padding
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(FREGISTRY),
                              ),
                            ),
                            //button Face registration
                            TextButton(
                              onPressed: () {
                                // Acción al presionar el botón
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.grass, // Icono predefinido de Flutter
                                    color: UNNOTICED, // Color del icono
                                    size: SIZED_ICON_LARGE, // Tamaño del icono
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Espacio entre el icono y el texto
                                  Text(
                                    'Facial registration',
                                    style: TextStyle(
                                      // Estilos del texto del botón
                                      fontSize: P1,
                                      color: UNNOTICED,
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(15.0), // Define el padding
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(WARNING),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Find out more',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H2,
                            color: NORMAL),
                      ),
                      const Text(
                        'Access enabled in:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: P1,
                            color: PRIMARY),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Map botton
                      Container(
                        //padding: const EdgeInsets.all(20),
                        color: SECONDARY,
                        constraints:
                            BoxConstraints.expand(height: homeCtrl.sectionHeight / 3),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, // Unfilled

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // Border radius
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/mapa_iztapalapa.png'), // *Path images
                                fit: BoxFit.cover, // Image adjustment
                              ),
                            ),
                            child: Container(),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              homeCtrl.signOut();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(DANGER),
                            ),
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                  color: UNNOTICED,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                //*footer
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    //color: ACC_SUCCESFULL,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        Text(
                          'safUAMI ',
                          style: TextStyle(color: PRIMARY),
                        ),
                        // link buttom
                        Text(
                          'v1.01',
                          style: TextStyle(color: SECONDARY),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
      backgroundColor: BACKGROUND,
    );
  }
}
