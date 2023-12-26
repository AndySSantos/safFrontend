import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/signin_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends GetView<SigninController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text('HomePage')),

      body: SafeArea(
        child: GetBuilder<SigninController>(
          init: SigninController(screenSize),
          builder: (signinCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    constraints: BoxConstraints.expand(
                        height: signinCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //*buttom return login
                        TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                            signinCtrl.returnLoginPage();
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
                            //user avatar
                            SizedBox(
                              child: Image.asset('assets/images/person3.png'),
                            ),
                            //Spacer(), // Espacio igual entre las imágenes
                            //traffic light
                            SizedBox(
                              child: Image.asset('assets/images/Red.png'),
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
                        height: signinCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //LABELS
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: H1,
                            fontWeight: FontWeight.bold,
                            color: UNNOTICED,
                          ),
                        ),
                        const Text(
                          'Please fill the input blow here',
                          style: TextStyle(
                              color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //*Inputs
                        //*Input emailUser
                        TextField(
                          controller: signinCtrl.emailCnt,
                          decoration: InputDecoration(
                            labelText: "EMAIL",
                            labelStyle: const TextStyle(color: UNNOTICED),
                            filled: true,
                            fillColor: FREGISTRY,
                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            //prefixIcon: Image.asset('/assets/images/icon_Mail_.png') ,
                          ),
                          style: const TextStyle(color: UNNOTICED),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //*Input password
                        TextField(
                          controller: signinCtrl.passCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "PASSWORD",
                            labelStyle: const TextStyle(color: UNNOTICED),
                            filled: true,
                            fillColor: FREGISTRY,
                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            //prefixIcon: Image.asset('/assets/images/icon_Mail_.png') ,
                          ),
                          style: const TextStyle(color: UNNOTICED),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //*input confirm password
                        TextField(
                          controller: signinCtrl.confirmPassCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "CONFIRM PASSWORD",
                            labelStyle: const TextStyle(color: UNNOTICED),
                            filled: true,
                            fillColor: FREGISTRY,
                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            //prefixIcon: Image.asset('/assets/images/icon_Mail_.png') ,
                          ),
                          style: const TextStyle(color: UNNOTICED),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Button Login
                            TextButton(
                              onPressed: () {
                                signinCtrl.formFieldsValidation();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(SECONDARY),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: NORMAL,
                                  fontSize: H4,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //text
                          const Text(
                            'Already have a account? ',
                            style: TextStyle(color: PRIMARY),
                          ),
                          // link buttom
                          TextButton(
                              onPressed: () {
                                signinCtrl.returnLoginPage();
                              },
                              child: const Text('Login',
                                  style: TextStyle(color: SECONDARY))),
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
