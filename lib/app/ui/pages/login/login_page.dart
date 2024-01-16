import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/login_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    int headerHeight = (deviceHeight * 0.3).floor();
    int sectionHeight = (deviceHeight * 0.6).floor();
    int footerHeight = (deviceHeight * 0.1).floor();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        //appBar: AppBar(title: const Text('LoginPage'),backgroundColor: Colors.amber,),

        body: SafeArea(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                //* header
                Container(
                  constraints:
                      BoxConstraints.expand(height: headerHeight.toDouble()),

                  //child: Text('HEADER: $headerHeight'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Distribuye el espacio entre los widgets
                    children: [
                      //user avatar
                      SizedBox(
                        child: Image.asset('assets/images/person1.png'),
                      ),
                      //Spacer(), // Espacio igual entre las imágenes
                      //traffic light
                      SizedBox(
                        child: Image.asset('assets/images/semaforo.png'),
                      ),
                    ],
                  ),
                ),
                //* section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    constraints: BoxConstraints.expand(),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      //color: ACC_PROS,
                    ),

                    //widgets form login
                    child: GetBuilder<LoginController>(
                      builder: (loginCtrl) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //label LOGIN
                            const Text(
                              'Login',
                              style: TextStyle(fontSize: H1, color: UNNOTICED),
                            ),
                            //label : Please sign in to continue
                            const Text(
                              'Please sign in to continue.',
                              style: TextStyle(color: PRIMARY),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Input emailUser
                            TextField(
                              controller: loginCtrl.emailCnt,
                              decoration: InputDecoration(
                                labelText: "email@izt.uam.mx",
                                labelStyle: const TextStyle(color: C_DATE),
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
                            //Input password
                            TextField(
                              controller: loginCtrl.passCnt,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "password",
                                labelStyle: const TextStyle(color: C_DATE),
                                filled: true,
                                fillColor: FREGISTRY,
                                //enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                //prefixIcon: Image.asset('/assets/images/icon_Lock_.png') ,
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
                                    loginCtrl.validateFields();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(SECONDARY),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: NORMAL,
                                      fontSize: H4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    loginCtrl.ForgotPassword();
                                  },
                                  child: const Text(
                                    'Forgot password',
                                    style: TextStyle(
                                        color: SECONDARY,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            //link: Forgoten password
                            Spacer(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //text
                                const Text(
                                  'Don`t have an account? ',
                                  style: TextStyle(color: PRIMARY),
                                ),
                                // link buttom
                                TextButton(
                                    onPressed: () {
                                      loginCtrl.changeToSignin();
                                    },
                                    child: const Text('Sign in',
                                        style: TextStyle(color: SECONDARY))),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                //* footer
                /*Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        const Text(
                          'Don`t have an account? ',
                          style: TextStyle(color: PRIMARY),
                        ),
                        // link buttom
                        TextButton(
                          onPressed: (){
                            
                          },
                          child: const Text('Sign in',style: TextStyle(color: SECONDARY))
                        ),
                        
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
        backgroundColor: BACKGROUND);
  }
}
