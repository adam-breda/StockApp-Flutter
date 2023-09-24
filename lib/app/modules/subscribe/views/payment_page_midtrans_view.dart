import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../main.dart';
import '../../../Values/values.dart';
import '../../news_detail/controllers/news_detail_controller.dart';
import '../controllers/midtrans_controller.dart';
import '../controllers/payment_midtrans_controller.dart';

class PaymentPageMidtransView extends GetView<PaymentMidtransController> {
  PaymentPageMidtransView({Key? key}) : super(key: key);
  PaymentMidtransController controller = Get.put(PaymentMidtransController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Text(
            "Payment",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent[400],
            ));
          }

          final formatter = NumberFormat('#,###');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Card(
                      // color: isHovered ? Colors.blue : Colors.white,
                      elevation: 4,
                      color: secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: InkWell(
                          splashColor: Colors.redAccent.withAlpha(30),
                          onTap: () {
                            // Get.toNamed(Routes.PAYMENT_PAGE_MIDTRANS, arguments: {
                            //   'name': subs['name'],
                            //   'month': subs['month'],
                            //   'price': subs['price'],
                            //   //   // 'nama_saham': allPorto['nama_saham'],
                            //   //   // 'total_volume_beli': allPorto['total_volume_beli'],
                            //   //   // 'avg_harga_beli': allPorto['url'],
                            //   //   // 'total_volume_jual': allPorto['total_volume_jual'],
                            //   //   // 'avg_harga_jual': allPorto['avg_harga_jual'],
                            // });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(subs['name'],
                                    //     style: TextStyle(
                                    //       color: Colors.black87,
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w400,
                                    //     )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(subs['email'],
                                    //     style: TextStyle(
                                    //         // fontWeight: FontWeight.bold,
                                    //         fontSize: 13)),
                                    Text(
                                        controller.arguments['month']
                                                .toString() +
                                            " Month",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(subs['email'],
                                    //     style: TextStyle(
                                    //         // fontWeight: FontWeight.bold,
                                    //         fontSize: 13)),
                                    Text(
                                        CurrencyFormat.convertToIdr(
                                            controller.arguments['price'], 0),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(subs['email'],
                                        //     style: TextStyle(
                                        //         // fontWeight: FontWeight.bold,
                                        //         fontSize: 13)),
                                        // Text(subs['price'].toString(),
                                        //     style: TextStyle(
                                        //         // fontWeight: FontWeight.bold,
                                        //         fontSize: 13)),
                                        Text(
                                            "• " +
                                                controller.arguments['month']
                                                    .toString() +
                                                " Month Subscription",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text("• Stock Analysis",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text("• Portofolio Review",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text("• General Analysis",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      controller.callPayment(context);
                      // if (controller.arguments['price'] != 0) {
                      //   var order_id = DateTime.now().millisecondsSinceEpoch;

                      //   Map data = {
                      //     "order_id": order_id.toString(),
                      //   };
                      //   var body = jsonEncode(data);
                      //   Get.defaultDialog(
                      //       title: " PAYMENT ",
                      //       content: Text("order id" + body));
                      // }
                      // controller.fetchTechnical(
                      //     //percentController.text,
                      //     );
                      // controller.tampildata(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(140, 40),
                        backgroundColor: buttoncolor),
                    child: Text('Proceed to Pay'),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

_launchURL(String url) async {
  if (!await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
