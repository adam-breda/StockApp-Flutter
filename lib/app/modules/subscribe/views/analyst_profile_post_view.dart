import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:stock_app/app/modules/subscribe/controllers/detailanalyst_controller.dart';
import 'package:stock_app/app/modules/subscribe/controllers/midtrans_controller.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/public_post_detail_controller.dart';
import '../controllers/subscribe_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class AnalystProfilePostView extends GetView<DetailAnalystController> {
  AnalystProfilePostView({Key? key}) : super(key: key);
  DetailAnalystController controller = Get.put(DetailAnalystController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchDetailAnalyst(); // Replace this with your actual data-fetching logic.
  }
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
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
          backgroundColor: primary,
          // appBar: AppBar(
          //   title: controller.arguments != null
          //       ? Column(
          //           // mainAxisAlignment: MainAxisAlignment.start,
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text("Profile Analyst", style: TextStyle(color: black)),

          //             // Text(controller.arguments['email'].toString(),
          //             //     style: TextStyle(
          //             //       fontWeight: FontWeight.w900,
          //             //       color: Colors.black87,
          //             //     )),
          //             // Text(controller.arguments['id'].toString(),
          //             //     style: TextStyle(
          //             //         fontWeight: FontWeight.w900, color: black)),
          //           ],
          //         )
          //       : Text(""),
          //   centerTitle: false,
          // ),
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

            return SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  //Text(controller.detailAnalyst.value['followers'].toString()),
                  Container(
                    color: secondary,
                    child: Column(
                      children: [],
                    ),
                  ),
                  SizedBox(height: 20),

                  ...(controller.detailAnalyst.value['post'] as List<dynamic>)
                      .map((it) => Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 5),
                            child: Card(
                                color: secondary,
                                //margin: EdgeInsets.only(bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  splashColor: Colors.redAccent.withAlpha(30),
                                  onTap: () {
                                    Get.toNamed(Routes.PUBLIC_POST_DETAIL,
                                        arguments: {
                                          'id_post': it['id_post'],
                                          'title': it['title'],
                                          'content': it['content'],
                                          'picture': it['picture'],
                                          'id_user': it['id_user'],
                                          'id_saham': it['id_saham'],
                                          'tag': it['tag'],
                                          'name': it['name'],
                                          'created_at': it['created_at'],
                                          'updated_at': it['updated_at'],
                                        });
                                  },
                                  child: Container(
                                      // width: Get.width * .5,
                                      // margin: EdgeInsets.only(bottom: 30),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              // spreadRadius: 2,
                                              //   blurRadius: 0.1,
                                              offset: Offset(0, 1.5),
                                            ),
                                          ],
                                          color: secondary,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Image.network(
                                              //   it['picture'],
                                              //   width: Get.width * 0.1,
                                              //   //height: Get.height,
                                              // ),
                                              // Text(
                                              //   it['picture'],
                                              //   maxLines: 3,
                                              // ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: Get.width * 0.86,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Image.network(
                                                      //   it['picture'].toString(),
                                                      //   width: Get.width,
                                                      //   //height: Get.height,
                                                      // ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      // Container(
                                                      //   width: Get.width * 0.76,
                                                      //   child: Image.network(
                                                      //     it['picture'],
                                                      //     // overflow: TextOverflow
                                                      //     //     .ellipsis,
                                                      //     // maxLines: 3,
                                                      //     // style: TextStyle(
                                                      //     //   fontWeight:
                                                      //     //       FontWeight.w600,
                                                      //     //   fontSize: 17,
                                                      //     // ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        width: Get.width * 0.76,
                                                        child: Text(
                                                          it['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.85,
                                                        child: Text(
                                                          it['content'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   _launchURL(
                                                      //   //       'https://www.google.com/'); // Ganti dengan URL yang Anda inginkan
                                                      //   // },
                                                      //   onTap: () {
                                                      //     _launchURL(it[
                                                      //         'url']); // Ganti dengan URL yang Anda inginkan
                                                      //   },
                                                      //   child: Text(
                                                      //     '...read more',
                                                      //     style: TextStyle(
                                                      //       decoration: TextDecoration.underline,
                                                      //       color: Colors.blue,
                                                      //       fontSize: 12,
                                                      //     ),
                                                      //   ),
                                                      // ),

                                                      // Container(
                                                      //   // it['url']
                                                      //   child: Text(
                                                      //     "...read more",
                                                      //     style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight: FontWeight.bold,
                                                      //       color: Colors.blue,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 65,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 4,
                                                                    bottom: 4),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: it['tag'] ==
                                                                        'private'
                                                                    ? Colors
                                                                        .redAccent
                                                                        .withOpacity(
                                                                            .2)
                                                                    : Colors
                                                                        .green
                                                                        .withOpacity(
                                                                            .2)),
                                                            child: Text(
                                                              it['tag'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                          // Container(
                                                          //   child: Text(
                                                          //     it['tag'].toString(),
                                                          //     style: TextStyle(
                                                          //         fontSize: 11,
                                                          //         fontWeight:
                                                          //             FontWeight.w400),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Icon(
                                              //       Icons.monetization_on,
                                              //       size: 16,
                                              //       color: Colors.redAccent[400],
                                              //     ),
                                              //     SizedBox(
                                              //       width: 5,
                                              //     ),
                                              //     Text(
                                              //         style: TextStyle(
                                              //             color: Colors.redAccent[400],
                                              //             fontWeight: FontWeight.bold,
                                              //             fontSize: 15),
                                              //         // formatter.format(double.parse(
                                              //         it['subscribe_fee'].toString()
                                              //         //  )
                                              //         // ),
                                              //         )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          // ElevatedButton(
                                          //     onPressed: () {
                                          //       Get.toNamed(Routes.it_PAGE,
                                          //           arguments: {'it': it});
                                          //     },
                                          //     style: ElevatedButton.styleFrom(
                                          //       backgroundColor: Colors.redAccent[400],
                                          //       minimumSize: Size(80, 36),
                                          //       padding: EdgeInsets.symmetric(horizontal: 5),
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius: BorderRadius.circular(5.0),
                                          //       ),
                                          //     ),
                                          //     child: Row(
                                          //       children: [
                                          //         Icon(Icons.visibility),
                                          //         SizedBox(
                                          //           width: 10,
                                          //         ),
                                          //         Text(
                                          //           "View",
                                          //           style: TextStyle(fontSize: 14),
                                          //         ),
                                          //       ],
                                          //     ))
                                        ],
                                      )),
                                )),
                          )),
                  SizedBox(height: 20),
                ],
              ),
            );
          })),
    );
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
