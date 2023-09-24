import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/modules/profile/controllers/detail_report_controller.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../../profile/views/profile_view.dart';

class DetailReportView extends GetView<DetailReportController> {
  DetailReportView({Key? key}) : super(key: key);
  DetailReportController controller = Get.put(DetailReportController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    // await controller
    //     .Report(); // Replace this with your actual data-fetching logic.
    await controller.DetailReportData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  width: screenWidth * 0.5,
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
                                                  Text('keuntungan'),
                                                  Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              inireport, 0),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [],
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
                    width: screenWidth * 0.5,
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
                                              Text('realisasi'),
                                              // Text(
                                              //     // CurrencyFormat.convertToIdr(
                                              //     //     allPorto['realisasi'], 0),
                                              //     allPorto.toString(),
                                              //     style: TextStyle(
                                              //         fontWeight:
                                              //             FontWeight.bold,
                                              //         fontSize: 15)),
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
                                                    fontWeight: FontWeight.w900,
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
                                                    fontWeight: FontWeight.bold,
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

                                      // SizedBox(
                                      //   width: 38,
                                      // ),
                                      Text(
                                          "Date : " + detailreportku['tanggal'],
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
                                              Text('Price'),
                                              Text(
                                                CurrencyFormat.convertToIdr(
                                                    detailreportku['harga'], 0),
                                                // detailreportku['harga']
                                                //     .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
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
                                            width: 30,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Volume'),
                                              Text(
                                                detailreportku['volume']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
