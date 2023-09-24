import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:stock_app/app/modules/subscribe/controllers/detailanalyst_controller.dart';
import 'package:stock_app/app/modules/subscribe/controllers/midtrans_controller.dart';
import 'package:stock_app/app/modules/subscribe/views/analyst_profile_post_view.dart';
import 'package:stock_app/app/modules/subscribe/views/analyst_profile_transaction_view.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/public_post_detail_controller.dart';
import '../controllers/subscribe_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class DetailAnalystView extends GetView<DetailAnalystController> {
  DetailAnalystView({Key? key}) : super(key: key);
  DetailAnalystController controller = Get.put(DetailAnalystController());
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

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: primary,
          body: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.arguments['name'].toString(),
                            style: TextStyle(
                                color: Colors.redAccent[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 4),
                          // Text(
                          //   "Analyst",
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //   ),
                          // )
                        ],
                      ),
                    ),

                    // Container(
                    //   width: Get.width / 7,
                    //   margin: EdgeInsets.only(top: 20),
                    //   alignment: Alignment.centerRight,
                    //   child: IconButton(
                    //     onPressed: () {
                    //       // controller.logout();
                    //     },
                    //     icon: Icon(
                    //       Icons.notifications,
                    //       size: 24.0,
                    //       color: black,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 15, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value == true) {
                          return Center(
                              child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.redAccent[400],
                              strokeWidth: 2.5,
                            ),
                          ));
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    controller.detailAnalyst.value['postCount']
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                SizedBox(width: 3),
                                Text('Post'),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Text(
                                  controller.detailAnalyst.value['followers']
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(width: 3),
                                Text('Followers'),
                              ],
                            ),
                          ],
                        );
                      }),
                      Divider(
                        color: Colors.black38,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TabBar(
                    indicatorColor: Colors.green[200],
                    indicatorWeight: 2,
                    //isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                          child: Text(
                        "Post",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                      Tab(
                          child: Text(
                        "Transaction",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    // SubscribedView(),
                    // SubscribeView2(),
                    AnalystProfilePostView(),
                    AnalystProfileTransactionView(),
                  ],
                )),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Get.toNamed(Routes.POST);
          //     // Aksi yang ingin dilakukan ketika tombol ditekan
          //   },
          //   child: Icon(Icons.add),
          //   backgroundColor: Colors.brown,
          // ),
        ));
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
