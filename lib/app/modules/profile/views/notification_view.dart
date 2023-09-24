import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/models/Subscribe.dart';

import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../routes/app_pages.dart';
import '../container_label.dart';
import '../controllers/profile_controller.dart';

class NotificationView extends GetView<ProfileController> {
  NotificationView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        // appBar: AppBar(
        //   title: const Text('Tagihan'),
        // ),
        body: FutureBuilder<List<Subscribe>>(
          future: apiService.fetchSubs('subscribed'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Subscribe> notifsubs = snapshot.data!;

              return ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: notifsubs.length,
                itemBuilder: (context, index) {
                  final tagihanItem = notifsubs[index];
                  final formatter = NumberFormat('#,###', 'id');
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          color: secondary,
                          elevation: 3,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   tagihanItem.status,
                                            //   style: TextStyle(
                                            //       fontSize: 17,
                                            //       fontWeight: FontWeight.bold),
                                            // ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            // Text(
                                            //   tagihanItem.expired.toString(),
                                            //   style: TextStyle(
                                            //       fontSize: 12,
                                            //       color: Colors.black87),
                                            // ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'ID ANALYST : ${tagihanItem.id_analyst}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // Text(
                                            //   tagihanItem.status,
                                            //   style: TextStyle(
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.green),
                                            // ),
                                          ],
                                        ),
                                        // Container(
                                        //     child: Text(
                                        //         formatter
                                        //             .format(tagihanItem.jumlah),
                                        //         style: TextStyle(
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.bold,
                                        //             color:
                                        //                 Colors.redAccent[400])))
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        )),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data'),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
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
