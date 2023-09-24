import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../controllers/porto_detail_controller.dart';

class PortoAllDetailView extends GetView<PortoDetailController> {
  PortoAllDetailView({Key? key}) : super(key: key);
  PortoDetailController controller = Get.put(PortoDetailController());
  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    // await controller
    //     .Report(); // Replace this with your actual data-fetching logic.
    await controller.ReportData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final formatter = NumberFormat('#,###');
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Text(
            controller.arguments['nama_saham'],
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(children: <Widget>[
          Container(
            height: screenHeight * 0.12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.65,
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  color: primary,
                  child: Obx(() {
                    if (controller.isLoading.value == true) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.redAccent[400],
                      ));
                    }
                    final formatter = NumberFormat('#,###');

                    return RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: controller.KeuntunganDetailReport.length,
                        itemBuilder: (context, index) {
                          final inireport =
                              controller.KeuntunganDetailReport[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                color: secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('floating return'),
                                                  Text(
                                                      "Rp " +
                                                          formatter.format(double
                                                              .parse(controller
                                                                  .arguments[
                                                                      'keuntungan']
                                                                  .toString())),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('equity'),
                                                  Text(
                                                      "Rp " +
                                                          formatter.format(double
                                                              .parse(controller
                                                                  .arguments[
                                                                      'total_banget']
                                                                  .toString())),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))),
                          );
                        },
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: screenWidth * 0.35,
                    color: primary,
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.redAccent[400],
                        ));
                      }
                      final formatter = NumberFormat('#,###');

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: controller.RealisasiDetailReport.length,
                        itemBuilder: (context, index) {
                          final allPorto =
                              controller.RealisasiDetailReport[index];
                          print(allPorto);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('profit'),
                                              Text(
                                                  CurrencyFormat.convertToIdr(
                                                      allPorto, 0),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))),
                          );
                        },
                      );
                    }),
                  ),
                ),
                // Container(
                //   width: screenWidth * 0.37,
                //   padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                //   color: primary,
                //   child: Obx(() {
                //     if (controller.isLoading.value == true) {
                //       return Center(
                //           child: CircularProgressIndicator(
                //         color: Colors.redAccent[400],
                //       ));
                //     }
                //     final formatter = NumberFormat('#,###');

                //     return RefreshIndicator(
                //       onRefresh: onRefresh,
                //       child: Card(
                //           color: secondary,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(15)),
                //           child: InkWell(
                //               child: Padding(
                //             padding: const EdgeInsets.all(15.0),
                //             child: Column(
                //               children: [
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Row(
                //                       children: [
                //                         Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.start,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Text('Amount',
                //                                 style: TextStyle(
                //                                     // fontWeight: FontWeight.bold,
                //                                     fontSize: 12)),
                //                             Text(
                // "Rp " +
                //     formatter.format(double.parse(
                //         controller.arguments[
                //                 'total_banget']
                //             .toString())),
                //                               // detailreportku['harga']
                //                               //     .toString(),
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 13,
                //                                 // color: double.parse(penutupan[
                //                                 //             'close']) >
                //                                 //         beliPorto['harga_beli']
                //                                 //     ? Colors.green[400]
                //                                 //     : Colors.red[400]
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.start,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [],
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ))),
                //     );
                //   }),
                // ),
                // Container(
                //   width: screenWidth * 0.37,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Amount',
                //           style: TextStyle(
                //               // fontWeight: FontWeight.bold,
                //               fontSize: 12)),
                //       Text(
                //         "Rp " +
                //             formatter.format(double.parse(controller
                //                 .arguments['total_banget']
                //                 .toString())),
                //         // detailreportku['harga']
                //         //     .toString(),
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 13,
                //           // color: double.parse(penutupan[
                //           //             'close']) >
                //           //         beliPorto['harga_beli']
                //           //     ? Colors.green[400]
                //           //     : Colors.red[400]
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.600,
            color: primary,
            child: Obx(() {
              if (controller.isLoading.value == true) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.redAccent[400],
                ));
              }
              final formatter = NumberFormat('#,###');

              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: controller.DetailReport.length,
                itemBuilder: (context, index) {
                  final detailreportku = controller.DetailReport[index];
                  final fee = detailreportku['tag'];

                  print(detailreportku);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                            splashColor: Colors.redAccent.withAlpha(30),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  detailreportku['nama_saham']
                                                      .toString(),
                                                  style: TextStyle(
                                                    //  color: Colors.redAccent,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    // color:
                                                    //     double.parse(penutupan['close']) >
                                                    //             beliPorto['harga_beli']
                                                    //         ? Colors.green[400]
                                                    //         : Colors.red[400]
                                                  )),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Text(''),
                                                  Text(" - ",
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
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Text(''),
                                                  Text(
                                                    detailreportku['tag']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: (detailreportku[
                                                                        'tag']
                                                                    .toString() ==
                                                                "beli")
                                                            ? Colors.green
                                                            : Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          // formatter.format(double.parse(
                                          //               controller.arguments[
                                          //                       'harga_close']
                                          //                   .toString())),

                                          // SizedBox(
                                          //   width: 38,
                                          // ),

                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text('fee',
                                          //         style: TextStyle(
                                          //             // fontWeight: FontWeight.bold,
                                          //             fontSize: 12)),
                                          //     Text(
                                          //       detailreportku['fee_$fee']
                                          //           .toString(),
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.bold,
                                          //           fontSize: 13),
                                          //     )
                                          //   ],
                                          // ),
                                          SizedBox(
                                            width: 15,
                                          ),

                                          // Text(
                                          //     "Date : " +
                                          //         detailreportku['fee'].toString(),
                                          //     style: TextStyle(
                                          //       fontSize: 12,
                                          //     )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "Fee : " +
                                                  detailreportku['fee_$fee']
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                              "Date : " +
                                                  detailreportku['tanggal'],
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
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
                                            detailreportku['nama_sekuritas']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Price',
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(
                                                CurrencyFormat.convertToIdr(
                                                    detailreportku['harga'], 0),
                                                // detailreportku['harga']
                                                //     .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  // color: double.parse(penutupan[
                                                  //             'close']) >
                                                  //         beliPorto['harga_beli']
                                                  //     ? Colors.green[400]
                                                  //     : Colors.red[400]
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Volume',
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(
                                                detailreportku['volume']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Close',
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(
                                                // detailreportku['volume']
                                                //     .toString(),
                                                formatter.format(double.parse(
                                                    controller.arguments[
                                                            'harga_close']
                                                        .toString())),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
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
                  );
                },
              );
            }),
          ),
        ]),
      ),
    );
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
