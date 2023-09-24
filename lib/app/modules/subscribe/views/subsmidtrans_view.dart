import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:stock_app/app/modules/subscribe/controllers/midtrans_controller.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/public_post_detail_controller.dart';
import '../controllers/subscribe_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class SubsMidtransView extends GetView<MidtransController> {
  SubsMidtransView({Key? key}) : super(key: key);
  MidtransController controller = Get.put(MidtransController());
  // DotEnv.load();

  // MidtransSDK? _midtrans;

  // void initSDK() async {
  //   _midtrans = await MidtransSDK.init(
  //     config: MidtransConfig(
  //       // clientKey: 'SB-Mid-client-kVq3vhRiVVY320TC',
  //       // merchantBaseUrl: 'SB-Mid-server-1LwxmvDQhFVSpHOvW35dDaHn',
  //       clientKey: DotEnv.env['SB-Mid-client-kVq3vhRiVVY320TC'] ?? "",
  //       merchantBaseUrl:
  //           DotEnv.env['SB-Mid-server-1LwxmvDQhFVSpHOvW35dDaHn'] ?? "",
  //       colorTheme: ColorTheme(
  //         colorPrimary: secondary,
  //         colorPrimaryDark: secondary,
  //         colorSecondary: secondary,
  //       ),
  //       enableLog: true,
  //     ),
  //   );
  //   _midtrans?.setUIKitCustomSetting(
  //     skipCustomerDetailsPages: true,
  //   );
  //   _midtrans!.setTransactionFinishedCallback((result) {
  //     print(result.toJson());
  //   });
  // }

//   var config = MidtransConfig(
//   clientKey: DotEnv.env['MIDTRANS_CLIENT_KEY'] ?? "",
//   merchantBaseUrl: DotEnv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
//   colorTheme: ColorTheme(
//     colorPrimary: Theme.of(context).accentColor,
//     colorPrimaryDark: Theme.of(context).accentColor,
//     colorSecondary: Theme.of(context).accentColor,
//   ),
// );

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Text(
            "Choose Plan",
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
          //  Text("Afwd");

          //Map<String, dynamic> dataa = controller.news;
          //print(dataa);
          final formatter = NumberFormat('#,###');

          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              // scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.subsAnalyst['prices'].length,
              itemBuilder: (context, index) {
                final subs = controller.subsAnalyst['prices'][index];

                return Card(
                    // color: isHovered ? Colors.blue : Colors.white,
                    elevation: 4,
                    color: secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                        splashColor: Colors.redAccent.withAlpha(30),
                        onTap: () {
                          Get.toNamed(Routes.PAYMENT_PAGE_MIDTRANS, arguments: {
                            'name': subs['name'],
                            'month': subs['month'],
                            'price': subs['price'],
                            'id_analyst': subs['id_analyst'],
                            'id': subs['id'],
                            //   // 'nama_saham': allPorto['nama_saham'],
                            //   // 'total_volume_beli': allPorto['total_volume_beli'],
                            //   // 'avg_harga_beli': allPorto['url'],
                            //   // 'total_volume_jual': allPorto['total_volume_jual'],
                            //   // 'avg_harga_jual': allPorto['avg_harga_jual'],
                          });
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
                                  Text(subs['month'].toString() + " Month",
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
                                          subs['price'], 0),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              subs['month'].toString() +
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

                                      // Text(
                                      //   "• " +
                                      //       subs['id_analyst'].toString() +
                                      //       " Month Subscription",
                                      // )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )));
              });
        }));
  }
}

Color get randomColor {
  List<Color> colors = [
    Colors.lime,
    Colors.redAccent,
    Colors.lightBlue,
    Colors.greenAccent
  ];
  return colors[Random().nextInt(colors.length)];
}


// _launchURL(String url) async {
//   if (!await canLaunch(url)) {
//     await launch(
//       url,
//       forceSafariVC: false,
//       forceWebView: false,
//       headers: <String, String>{'my_header_key': 'my_header_value'},
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }
