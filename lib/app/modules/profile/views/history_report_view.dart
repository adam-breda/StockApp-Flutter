import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_report_controller.dart';
import 'profile_view.dart';
import '../../porto/controllers/porto_controller.dart';

class HistoryReportView extends GetView<ProfileReportController> {
  HistoryReportView({Key? key}) : super(key: key);
  ProfileReportController controller = Get.put(ProfileReportController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    // await controller
    //     .Report(); // Replace this with your actual data-fetching logic.
    await controller.ReportHistory();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Text(
            controller.arguments['year'] ?? 0.toString(),
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
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
                    itemCount: controller.reportHistory.length,
                    itemBuilder: (context, index) {
                      final HistoryReport = controller.reportHistory[index];
                      //final penutupan = controller.companies[index];
                      //final inireport = controller.report[index];
                      // final inireport = controller.report[index];
                      //print(HistoryReport);

                      return Card(
                          color: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                              splashColor: Colors.redAccent.withAlpha(30),
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_REPORT, arguments: {
                                  'nama_saham':
                                      HistoryReport['nama_saham'].toString(),
                                  'year': HistoryReport['year'].toString(),
                                });
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              HistoryReport['nama_saham']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              )),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text('total'),
                                          //     // Text(time?.toString() ?? "Empty"),
                                          //     Text(
                                          //       // CurrencyFormat.convertToIdr(
                                          //       //     allPorto['sisa_aset'], 0),
                                          //       "Rp." +
                                          //           formatter.format(double
                                          //               .parse(HistoryReport[
                                          //                       'total_banget']
                                          //                   .toString())),
                                          //       // allPorto['keuntungan'].toString(),
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.w600,
                                          //           fontSize: 14),
                                          //     )
                                          //   ],
                                          // ),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text('keuntungan'),
                                          //     // Text(time?.toString() ?? "Empty"),
                                          //     Text(
                                          //       // CurrencyFormat.convertToIdr(
                                          //       //     HistoryReport['sisa_aset'], 0),
                                          //       "Rp." +
                                          //           formatter.format(double
                                          //               .parse(HistoryReport[
                                          //                       'keuntungan']
                                          //                   .toString())),
                                          //       // HistoryReport['keuntungan'].toString(),
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.bold,
                                          //           fontSize: 16),
                                          //     )
                                          //   ],
                                          // ),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text('sisa aset'),
                                          //     // Text(time?.toString() ?? "Empty"),
                                          //     Text(
                                          //       // CurrencyFormat.convertToIdr(
                                          //       //     HistoryReport['sisa_aset'], 0),
                                          //       "Rp." +
                                          //           formatter.format(
                                          //               double.parse(
                                          //                   HistoryReport[
                                          //                           'sisa_aset']
                                          //                       .toString())),
                                          //       // HistoryReport['keuntungan'].toString(),
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.bold,
                                          //           fontSize: 16),
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                              Text('sisa lot'),
                                              Text(
                                                  formatter.format(double.parse(
                                                      HistoryReport[
                                                              'total_volume']
                                                          .toString())),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('lot beli'),
                                              Text(
                                                  formatter.format(double.parse(
                                                      HistoryReport[
                                                              'total_volume_beli']
                                                          .toString())),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('lot jual'),
                                              Text(
                                                  formatter.format(double.parse(
                                                      HistoryReport[
                                                              'total_volume_jual']
                                                          .toString())),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('avg beli'),
                                              Text(
                                                  formatter.format(double.parse(
                                                      HistoryReport[
                                                          'avg_harga_beli'])),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    // color: Colors.black87,
                                                    fontSize: 14,
                                                    // color: double.parse(penutupan[
                                                    //             'close']) <
                                                    //         double.parse(HistoryReport[
                                                    //             'avg_harga_beli'])
                                                    //     ? Colors.green[400]
                                                    //     : Colors.red[400]
                                                  )),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('avg jual'),
                                              Text(
                                                  formatter.format(double.parse(
                                                      HistoryReport[
                                                              'avg_harga_jual']
                                                          .toString())),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    // color: Colors.black87,
                                                    fontSize: 14,
                                                    // color: double.parse(penutupan[
                                                    //             'close']) >
                                                    //         double.parse(HistoryReport[
                                                    //                 'avg_harga_jual']
                                                    //             .toString())
                                                    //     ? Colors.green[400]
                                                    //     : Colors.red[400]
                                                  )),
                                              // Text(
                                              //   HistoryReport['avg_harga_jual'].toString(),
                                              //   style: TextStyle(
                                              //       fontWeight: FontWeight.w600,
                                              //       fontSize: 16,
                                              //       color: double.parse(
                                              //                   penutupan['close']) >
                                              //               double.parse(
                                              //                   HistoryReport['avg_harga_jual']
                                              //                       .toString())
                                              //           ? Colors.green[400]
                                              //           : Colors.red[400]),
                                              // )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('close'),
                                              // Text(time?.toString() ?? "Empty"),
                                              Text(
                                                // CurrencyFormat.convertToIdr(
                                                //     HistoryReport['sisa_aset'], 0),

                                                formatter.format(double.parse(
                                                    HistoryReport['harga_close']
                                                        .toString())),
                                                //  HistoryReport['sisa_aset'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )));
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
