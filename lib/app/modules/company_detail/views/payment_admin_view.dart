import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../../profile/container_label.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/company_detail_controller.dart';

class PaymentAdminView extends GetView<CompanyDetailController> {
  PaymentAdminView({Key? key}) : super(key: key);
  CompanyDetailController controller = Get.put(CompanyDetailController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //         margin: EdgeInsets.only(left: 65),
            //         alignment: Alignment.center,
            //         width: 80,
            //         height: 80,
            //         decoration: BoxDecoration(
            //             color: Colors.redAccent.withOpacity(.2),
            //             borderRadius: BorderRadius.circular(120)),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Icon(
            //             Icons.person,
            //             size: 20,
            //             color: Colors.white,
            //           ),
            //         )),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 120),
                //   child: Obx(() => Text(
                //         controller.name.value,
                //         style: TextStyle(fontSize: 20),
                //       )),
                // ),
                ElevatedButton(
                  onPressed: () {
                    // controller.fetchTechnical(
                    //       //percentController.text,
                    //       );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fixedSize: Size(80, 18),
                      backgroundColor: buttoncolor),
                  child: Text(
                    'Upgrade',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     TextButton.icon(
                //       // <-- TextButton
                //       onPressed: () {
                //         // controller.logout();
                //       },
                //       icon: Icon(
                //         Icons.emoji_people,
                //         size: 24.0,
                //       ),
                //       label: Text('upgrade'),
                //     ),
                //   ],
                // ),
                // Container(
                //   width: Get.width / 7,
                //   // margin: EdgeInsets.only(top: 10),
                //   alignment: Alignment.centerRight,

                //   child: TextButton.icon(
                //     // <-- TextButton
                //     onPressed: () {
                //       controller.logout();
                //     },
                //     icon: Icon(
                //       Icons.emoji_people,
                //       size: 24.0,
                //     ),
                //     label: Text('upgrade'),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            ContainerLabel(label: "Profile"),
            SizedBox(
              height: 5,
            ),
            Card(
                color: secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('email'),
                              // Text(
                              //   controller.emailUser.value,
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status'),
                              Text(
                                controller.role.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            ContainerLabel(label: "Report"),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent[400],
                  ));
                }

                return ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  physics: ClampingScrollPhysics(),
                  //  itemCount: controller.report.length,
                  itemBuilder: (context, index) {
                    // final profilereport = controller.report[index];
                    ContainerLabel(label: "Report");

                    // return Card(
                    //     color: secondary,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)),
                    //     child: InkWell(
                    //       splashColor: Colors.redAccent.withAlpha(30),
                    //       child: Container(
                    //           padding: EdgeInsets.all(16),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Column(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text('Year'),
                    //                   Text(
                    //                     profilereport['year'].toString(),
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               Column(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text('Keuntungan'),
                    //                   Text(
                    //                     CurrencyFormat.convertToIdr(
                    //                         profilereport['keuntungan'], 0),
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               Column(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text('Realisasi'),
                    //                   Text(
                    //                     CurrencyFormat.convertToIdr(
                    //                         profilereport['realisasi'], 0),
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 14),
                    //                   )
                    //                 ],
                    //               ),
                    //             ],
                    //           )),
                    //     ));
                  },
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: Get.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextButton.icon(
                //   // <-- TextButton
                //   onPressed: () {
                //     controller.logout();
                //   },
                //   icon: Icon(
                //     Icons.logout,
                //     size: 24.0,
                //   ),
                //   label: Text('logout'),
                // ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notif();
          // Get.toNamed(Routes.POST);
          // Aksi yang ingin dilakukan ketika tombol ditekan
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}

void notif() {
  _firebaseMessaging.requestPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
  });
}

class _firebaseMessaging {
  _firebaseMessaging.requestPermission();
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
