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

class AnalystProfileTransactionView extends GetView<DetailAnalystController> {
  AnalystProfileTransactionView({Key? key}) : super(key: key);
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
  //var nomornul = 0;
  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchDetailAnalyst(); // Replace this with your actual data-fetching logic.
  }

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
          backgroundColor: primary,
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
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ContainerLabel(label: "Sale"),
                  ),

                  ...(controller.PortoJualAnalyst.value['dataporto']
                          as List<dynamic>)
                      .map((jual) => Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Card(
                                color: secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                    splashColor: Colors.redAccent.withAlpha(30),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  //Text("Sale"),
                                                  Text(
                                                      jual['nama_saham']
                                                          .toString(),
                                                      style: TextStyle(
                                                        //  color: Colors.redAccent,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        // color:
                                                        //     double.parse(penutupan['close']) >
                                                        //             beliPorto['harga_beli']
                                                        //         ? Colors.green[400]
                                                        //         : Colors.red[400]
                                                      )),
                                                  SizedBox(width: 10),
                                                  // Column(
                                                  //   children: [
                                                  //     Text(
                                                  //         "Fee beli : " +
                                                  //             it['fee_beli'],
                                                  //         style: TextStyle(
                                                  //           fontSize: 12,
                                                  //         )),
                                                  //     Text(
                                                  //         "Fee Jual : " +
                                                  //             it['fee_jual'],
                                                  //         style: TextStyle(
                                                  //           fontSize: 12,
                                                  //         )),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Sale Date : " +
                                                          jual['tanggal_jual'],
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
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
                                                  Text('Sekuritas'),
                                                  Text(
                                                    jual['nama_sekuritas']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Profit ',
                                                        style: TextStyle(
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontSize: 13,
                                                          // color: double.parse(
                                                          //             penutupan['close']) >
                                                          //         beliPorto['harga_beli']
                                                          //     ? Colors.green[400]
                                                          //     : Colors.red[400]
                                                        ),
                                                      ),
                                                      Text(
                                                        jual['close_persen']
                                                                .toString() +
                                                            "%",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          // color: double.parse(jual[
                                                          //             'close_persen']) >
                                                          //         double.parse(jual[
                                                          //             'harga_jual'])
                                                          //     ? Colors
                                                          //         .green[400]
                                                          //     : Colors
                                                          //         .red[400]
                                                        ),
                                                      ),
                                                      SizedBox(width: 60),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Price',
                                                            style: TextStyle(
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontSize: 13,
                                                              // color: double.parse(
                                                              //             penutupan['close']) >
                                                              //         beliPorto['harga_beli']
                                                              //     ? Colors.green[400]
                                                              //     : Colors.red[400]
                                                            ),
                                                          ),
                                                          Text(
                                                            jual['harga_jual']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              // color: double.parse(
                                                              //             penutupan['close']) >
                                                              //         beliPorto['harga_beli']
                                                              //     ? Colors.green[400]
                                                              //     : Colors.red[400]
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Volume',
                                                            style: TextStyle(
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontSize: 13,
                                                              // color: double.parse(
                                                              //             penutupan['close']) >
                                                              //         beliPorto['harga_beli']
                                                              //     ? Colors.green[400]
                                                              //     : Colors.red[400]
                                                            ),
                                                          ),
                                                          Text(
                                                            jual['volume']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))),
                          )),

                  Container(
                    color: secondary,
                    child: Column(
                      children: [],
                    ),
                  ),
                  SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ContainerLabel(label: "Buy"),
                  ),
                  ...(controller.PortoBeliAnalyst.value['dataporto']
                          as List<dynamic>)
                      .map((it) => Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Card(
                                color: secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                    splashColor: Colors.redAccent.withAlpha(30),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      it['nama_saham']
                                                          .toString(),
                                                      style: TextStyle(
                                                        //  color: Colors.redAccent,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        // color:
                                                        //     double.parse(penutupan['close']) >
                                                        //             beliPorto['harga_beli']
                                                        //         ? Colors.green[400]
                                                        //         : Colors.red[400]
                                                      )),
                                                  SizedBox(width: 10),
                                                  // Column(
                                                  //   children: [
                                                  //     Text(
                                                  //         "Fee beli : " +
                                                  //             it['fee_beli'],
                                                  //         style: TextStyle(
                                                  //           fontSize: 12,
                                                  //         )),
                                                  //     Text(
                                                  //         "Fee Jual : " +
                                                  //             it['fee_jual'],
                                                  //         style: TextStyle(
                                                  //           fontSize: 12,
                                                  //         )),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                              Text(
                                                  "Buy Date : " +
                                                      it['tanggal_beli'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
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
                                                  Text('Sekuritas'),
                                                  Text(
                                                    it['nama_sekuritas']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Price'),
                                                      Text(
                                                        it['harga_beli']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          // color: double.parse(
                                                          //             penutupan['close']) >
                                                          //         beliPorto['harga_beli']
                                                          //     ? Colors.green[400]
                                                          //     : Colors.red[400]
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 38,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Volume'),
                                                      Text(
                                                        it['volume'].toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))),
                          )),
                  SizedBox(height: 20),

                  // ...(controller.PortoJualAnalyst.value['dataportojual']
                  //         as List<dynamic>)
                  //     .map((it) => Padding(
                  //           padding:
                  //               EdgeInsets.only(left: 15, right: 15, top: 10),
                  //           child: Card(
                  //               color: secondary,
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(15)),
                  //               child: InkWell(
                  //                   splashColor: Colors.redAccent.withAlpha(30),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(15.0),
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 Text(
                  //                                     it['nama_saham'].toString(),
                  //                                     style: TextStyle(
                  //                                       //  color: Colors.redAccent,
                  //                                       fontSize: 20,
                  //                                       fontWeight:
                  //                                           FontWeight.w900,
                  //                                       // color:
                  //                                       //     double.parse(penutupan['close']) >
                  //                                       //             beliPorto['harga_beli']
                  //                                       //         ? Colors.green[400]
                  //                                       //         : Colors.red[400]
                  //                                     )),
                  //                                 SizedBox(width: 10),
                  //                                 // Column(
                  //                                 //   children: [
                  //                                 //     Text(
                  //                                 //         "Fee beli : " +
                  //                                 //             it['fee_beli'],
                  //                                 //         style: TextStyle(
                  //                                 //           fontSize: 12,
                  //                                 //         )),
                  //                                 //     Text(
                  //                                 //         "Fee Jual : " +
                  //                                 //             it['fee_jual'],
                  //                                 //         style: TextStyle(
                  //                                 //           fontSize: 12,
                  //                                 //         )),
                  //                                 //   ],
                  //                                 // ),
                  //                               ],
                  //                             ),
                  //                             Text(
                  //                                 "Buy Date : " +
                  //                                     it['tanggal_beli'],
                  //                                 style: TextStyle(
                  //                                   fontSize: 12,
                  //                                 )),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 15,
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Column(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 Text('Sekuritas'),
                  //                                 Text(
                  //                                   it['nama_sekuritas']
                  //                                       .toString(),
                  //                                   style: TextStyle(
                  //                                     fontSize: 12,
                  //                                     fontWeight: FontWeight.bold,
                  //                                   ),
                  //                                 )
                  //                               ],
                  //                             ),
                  //                             Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.end,
                  //                               children: [
                  //                                 Column(
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment.start,
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     Text('Price'),
                  //                                     Text(
                  //                                       it['harga_beli']
                  //                                           .toString(),
                  //                                       style: TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         fontSize: 16,
                  //                                         // color: double.parse(
                  //                                         //             penutupan['close']) >
                  //                                         //         beliPorto['harga_beli']
                  //                                         //     ? Colors.green[400]
                  //                                         //     : Colors.red[400]
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(
                  //                                   width: 38,
                  //                                 ),
                  //                                 Column(
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment.start,
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     Text('Volume'),
                  //                                     Text(
                  //                                       it['volume'].toString(),
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           fontSize: 16),
                  //                                     )
                  //                                   ],
                  //                                 ),
                  //                                 Column(
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment.start,
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     Text('Close'),
                  //                                     Text(
                  //                                       it['close_persen']
                  //                                           .toString(),
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           fontSize: 16),
                  //                                     )
                  //                                   ],
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           ],
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ))),
                  //         )),
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
