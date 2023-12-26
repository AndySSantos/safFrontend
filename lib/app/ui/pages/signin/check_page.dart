import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/check_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckPage extends GetView<CheckController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text('CheckPage')),

      body: SafeArea(
        child: GetBuilder<CheckController>(
          init: CheckController(screenSize),
          builder: (checkCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //*Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: checkCtrl.headerHeight.toDouble()),
                    //color:ACC_DENIED,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset('assets/images/Yellow.png'),
                        ),
                      ],
                    ),
                  ),
                  //*Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(
                        height: checkCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify your email',
                          style: TextStyle(
                              color: UNNOTICED,
                              fontSize: H1,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Please enter the code send to email',
                          style: TextStyle(
                              color: PRIMARY, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //*Input code
                        TextField(
                          controller: checkCtrl.code,
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
                          height: 20,
                        ),
                        //?Button Resend code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                checkCtrl.sendCode();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //?Button confirm account
                            TextButton(
                              onPressed: () {
                                checkCtrl.validateCodeAccount();
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
