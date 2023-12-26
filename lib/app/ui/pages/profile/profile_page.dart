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
                              height: (profileCtrl.headerHeight * 0.9 -
                                      profileCtrl.footerHeight * 0.9)
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
                    constraints: BoxConstraints.expand(
                        height: profileCtrl.sectionHeight.toDouble()),
                    color: ACC_PROS,
                    child: Column(
                      children: [
                        const Text('Please fill the input blow here', style: TextStyle(color: PRIMARY),),
                        
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
    );
  }
}
