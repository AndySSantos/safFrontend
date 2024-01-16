import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/forgot_password_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('ForgotPasswordPage')),

      body: SafeArea(
        child: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(screenSize),
          builder: (forgotPasswordCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: forgotPasswordCtrl.headerHeight.toDouble()),
                    //color:ACC_DENIED,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset('assets/images/person5.png',),
                          
                        ),
                      ],
                    ),
                  ),
                  //*Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: forgotPasswordCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recover access.',
                          style: TextStyle(
                              color: UNNOTICED,
                              fontSize: H1,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'If the email is associated with an account in our system you will receive a notification:',
                          style: TextStyle(
                              color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //*Input email
                        TextField(
                          controller: forgotPasswordCtrl.emailCnt,
                          decoration: InputDecoration(
                            labelText: "e-mail",
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
                        //?Button send code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //?Button confirm account
                            TextButton(
                              onPressed: () {
                                forgotPasswordCtrl.ForgotRequest();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(SECONDARY),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  color: NORMAL,
                                  fontSize: H4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //? Boton cancelar
                            TextButton(
                              onPressed: () {
                                forgotPasswordCtrl.CancelProcess();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(ACC_DENIED),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: NORMAL,
                                  fontSize: H4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                  //*Footer
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      //color: ACC_SUCCESFULL,
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
