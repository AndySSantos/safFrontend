import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/profile_controller.dart';
import 'package:safuami/app/ui/utils/style_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla del dispositivo
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text('ProfilePage')),
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: GetBuilder<ProfileController>(
          init: ProfileController(screenSize),
          builder: (profileCtrl) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  //* Header
                  Container(
                    padding: const EdgeInsets.all(5),
                    constraints: BoxConstraints.expand(
                        height: profileCtrl.headerHeight.toDouble()),
                    //color: ACC_DENIED,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * Date
                        Text(
                          profileCtrl.today,
                          style: TextStyle(
                            color: C_DATE,
                          ),
                        ),
                        // * avatar
                        Container(
                          //padding: const EdgeInsets.all(10),
                          //color: C_DATE,
                          constraints: BoxConstraints.expand(
                              height: (profileCtrl.headerHeight * 0.9 -
                                      profileCtrl.footerHeight * 0.9)
                                  .toDouble()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(profileCtrl.profileResum,
                                  style: TextStyle(color: PRIMARY),
                                ),
                              ),
                              //Text('Avatar')
                              SizedBox(
                                //child: Image.asset('assets/images/person2.png'),
                                child: InkWell(
                                  onTap: () {
                                    // Action by pressing the image
                                    //print('The Avatar was pushed');
                                    //profileCtrl.openAccountSettings();
                                    // Launch any action here
                                  },
                                  child:
                                      Image.asset('assets/images/person4.png'),
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
                  //*Section
                  Container(
                    padding: const EdgeInsets.all(SPACE_BETWEEN_WITGETS),
                    constraints: BoxConstraints.expand(
                        height: profileCtrl.sectionHeight.toDouble()),
                    //color: ACC_PROS,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Please fill the input blow here',
                          style: TextStyle(color: PRIMARY),
                        ),
                        const SizedBox(
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* New user name textfield
                        TextField(
                          controller: profileCtrl.userCnt,
                          decoration: InputDecoration(
                            labelText: "NEW USER NAME",
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
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* NEW EMAIL textField
                        TextField(
                          controller: profileCtrl.emailCnt,
                          decoration: InputDecoration(
                            labelText: "NEW EMAIL",
                            labelStyle: const TextStyle(color: UNNOTICED),
                            filled: true,
                            fillColor: FREGISTRY,
                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            //prefixIcon: Image.asset('/assets/images/icon_Mail_.png',width: 10 ,height: 5,) ,
                          ),
                          style: const TextStyle(color: UNNOTICED),
                        ),
                        const Text('To save changes enter your password:',style: TextStyle(color: PRIMARY),),
                        const SizedBox(
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* Password textField
                        TextField(
                          controller: profileCtrl.passCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "YOUR PASSWORD",
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
                          height: SPACE_BETWEEN_WITGETS,
                        ),

                        //* New Password fields
                        Text('Create new password',style: TextStyle(color: PRIMARY),),
                        const SizedBox(
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* field New password
                        TextField(
                          controller: profileCtrl.newPassCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "New PASSWORD",
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
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* field Cornfirm new password
                        TextField(
                          controller: profileCtrl.confirmNewPassCnt,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "YOUR PASSWORD",
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
                          height: SPACE_BETWEEN_WITGETS,
                        ),
                        //* Buttons actions: DELETE ACCOUNT, SAVE CHANGES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //* Delete account
                            TextButton(
                              onPressed: () {
                                // Acción al presionar el botón
                                profileCtrl.actionDeleteAccount();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete_forever_rounded, // Icono predefinido de Flutter
                                    color: UNNOTICED, // Color del icono
                                    size: SIZED_ICON_MEDIUM, // Tamaño del icono
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Espacio entre el icono y el texto
                                  Text(
                                    'Delete account',
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
                                    MaterialStateProperty.all(DANGER),
                              ),
                            ),

                            //* save changes

                            TextButton(
                              onPressed: () {
                                // Acción al presionar el botón
                                profileCtrl.actionSaveChanges();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.save_as, // Icono predefinido de Flutter
                                    color: UNNOTICED, // Color del icono
                                    size: SIZED_ICON_MEDIUM, // Tamaño del icono
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Espacio entre el icono y el texto
                                  Text(
                                    'Save changes',
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
                                    MaterialStateProperty.all(INFO),
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
