import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/change_password_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('ChangePasswordPage')),

      body: SafeArea(
        child: GetBuilder<ChangePasswordController>(
          init: ChangePasswordController(screenSize),
          builder: (changePasswordCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    //padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: changePasswordCtrl.headerHeight.toDouble()),
                    //color:ACC_DENIED,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset('assets/images/person6.png',),
                          height: changePasswordCtrl.headerHeight/1.3,
                          width: changePasswordCtrl.headerHeight/1.3,
                        ),
                      ],
                    ),
                  ),
                  //*Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: changePasswordCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recover access.',
                          style: TextStyle(
                              color: UNNOTICED,
                              fontSize: H1,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Create new password for your account.',
                          style: TextStyle(
                              color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //*Input new password
                        TextField(
                          controller: changePasswordCtrl.passCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "New password",
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
                          height: 10,
                        ),

                        //* Input confirmation new password
                        TextField(
                          controller: changePasswordCtrl.confirmPassCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm new password",
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
                          height: 10,
                        ),
                        const Text(
                          'Enter code auth.',
                          style: TextStyle(
                              color: UNNOTICED,
                              fontSize: H1,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Eneter code send your email for save changes.',
                          style: TextStyle(
                              color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //*Input code
                        TextField(
                          controller: changePasswordCtrl.code,
                          decoration: InputDecoration(
                            labelText: "CODE",
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
                          height: 10,
                        ),
                        //?Button Resend code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                changePasswordCtrl.ResendCode();
                              },
                              child: const Text(
                                'Resend code',
                                style: TextStyle(color: SECONDARY,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //?Button change password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //?Button confirm account
                            TextButton(
                              onPressed: () {
                                changePasswordCtrl.ChangePasswordRequest();
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
