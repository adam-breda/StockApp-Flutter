import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../container_label.dart';
import '../controllers/profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller.Report();
    await controller.name.value;
    // await controller.CheckRequest();
    ; // Replace this with your actual data-fetching logic.
    // await controller.fetchPortoSemua();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.name.value,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.id_user.value,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextButton.icon(
                          //   onPressed: () {
                          //     controller.logout();
                          //   },
                          //   icon: Icon(
                          //     Icons.edit_note,
                          //     size: 24.0,
                          //     color: buttoncolor,
                          //   ),
                          //   label: Text('Logout'),
                          // ),
                          IconButton(
                            onPressed: () {
                              controller.nameC.text = controller.name.value;

                              Get.defaultDialog(
                                backgroundColor: primary,
                                title: "EDIT PROFILE",
                                content: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name"),
                                      SizedBox(height: 5),
                                      Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                        ),
                                        child: TextField(
                                          controller: controller.nameC,
                                          // keyboardType:
                                          //     TextInputType
                                          //         .number,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 13.0),
                                            hintText: 'Edit Name',
                                            hintStyle:
                                                TextStyle(fontSize: 11.0),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 12.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(() => Container(
                                                width: Get.width / 3,
                                                child: controller
                                                            .isSending.value ==
                                                        false
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          fixedSize:
                                                              Size(200, 40),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          // Handle update button press
                                                          controller
                                                              .updateMyProfile(
                                                                  controller
                                                                      .name
                                                                      .value);
                                                        },
                                                        child: Text("Update"),
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit_note,
                              size: 24.0,
                              color: buttoncolor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  // Obx(
                  //   () => controller.requestUser == "2"
                  //       ? Container(
                  //           child: ElevatedButton(
                  //             onPressed: () {
                  //               controller.requestAdmin();
                  //             },
                  //             style: ElevatedButton.styleFrom(
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(15),
                  //               ),
                  //               fixedSize: Size(80, 18),
                  //               backgroundColor: buttoncolor,
                  //             ),
                  //             child: Text(
                  //               'Upgrade',
                  //               style: TextStyle(fontSize: 12),
                  //             ),
                  //           ),
                  //         )
                  //       : SizedBox(),
                  // ),
                  Obx(
                    () => controller.role == "User"
                        ? Container(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.requestAdmin();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                fixedSize: Size(80, 18),
                                backgroundColor: buttoncolor,
                              ),
                              child: Text(
                                'Upgrade',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ContainerLabel(label: "Report"),
                  IconButton(
                    onPressed: () {
                      // controller.nameC.text = controller.name.value;
                      onRefresh();
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 16.0,
                      color: buttoncolor,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.redAccent[400],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(top: 0.0),
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.report.length,
                      itemBuilder: (context, index) {
                        final profilereport = controller.report[index];
                        // final request = controller.requestUser[index];
                        final formatter = NumberFormat('#,###');
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Container(),
                            Card(
                              color: secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                splashColor: Colors.redAccent.withAlpha(30),
                                onTap: () {
                                  Get.toNamed(Routes.HISTORY_REPORT,
                                      arguments: {
                                        'year': profilereport['year'] ??
                                            0.toString(),
                                        //'name': company['name'],
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Year'),
                                          Text(
                                            profilereport['year'] ??
                                                0.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Keuntungan'),
                                          Text(
                                            "Rp " +
                                                formatter.format(double.parse(
                                                    profilereport[
                                                            'keuntungan'] ??
                                                        0.toString())),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Realisasi'),
                                          Text(
                                            "Rp " +
                                                formatter.format(double.parse(
                                                    profilereport[
                                                            'realisasi'] ??
                                                        0.toString())),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text('Year'),
                            //     Text(
                            //       profilereport['year'] ?? 0.toString(),
                            //       style: TextStyle(fontWeight: FontWeight.bold),
                            //     )
                            //   ],
                            // ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              ContainerLabel(label: "About"),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.redAccent[400],
                        ),
                      );
                    }

                    return Container(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0.0),
                        physics: ClampingScrollPhysics(),
                        itemCount: controller.report.length,
                        itemBuilder: (context, index) {
                          final profilereport = controller.report[index];

                          return Card(
                            color: secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('email'),
                                          Text(
                                            controller.emailUser.value,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Status'),
                                          Text(
                                            controller.role.value,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => controller.role == "Analyst"
                                        ? InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                Routes.SUBSCRIBER_PROFILE,
                                                // arguments: {
                                                //   'year':
                                                //       profilereport['year']
                                                //           .toString(),
                                                //   //'name': company['name'],
                                                // }
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text('Followers'),
                                                    Text(
                                                      profilereport['followers']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text('Post'),
                                                    Text(
                                                      profilereport['postCount']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                  ),

                                  // Column(
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Text('Followers'),
                                  //         Text(
                                  //           profilereport['followers'].toString(),
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Text('Post'),
                                  //         Text(
                                  //           profilereport['postCount'].toString(),
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              // SizedBox(height: 10),

              SizedBox(height: 220),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        controller.logout();
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 24.0,
                        color: buttoncolor,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                            //  color: Colors.redAccent,
                            // fontSize: 20,
                            // fontWeight: FontWeight.w900,
                            color: buttoncolor),
                      )),
                ],
              ),
            ],
          ),
        ),
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
