import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/porto_controller.dart';

class PortoAllView extends GetView<PortoController> {
  PortoAllView({Key? key}) : super(key: key);
  PortoController controller = Get.put(PortoController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .Report(); // Replace this with your actual data-fetching logic.
    await controller.fetchPortoSemua();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //final inireport = controller.donekeuntungan;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        body: Container(
          color: primary,
          child: Column(children: <Widget>[
            Container(
              height: screenHeight * 0.15,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              color: primary,
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent[400],
                  ));
                }
                final formatter = NumberFormat('##,##0');

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.report.length,
                  itemBuilder: (context, index) {
                    final inireport = controller.report[index];

                    return Card(
                        color: secondary,
                        // margin: const EdgeInsets.only(top: 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(inireport['nama_saham'].toString(),
                              //         style: TextStyle(
                              //           color: Colors.black87,
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.w900,
                              //         )),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Text('Year'),
                                      Text(
                                        inireport['year'].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
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
                                          // Text('',
                                          //     style: TextStyle(
                                          //         // fontWeight: FontWeight.bold,
                                          //         fontSize: 12)),
                                          Text('floating return'),
                                          // Text(
                                          //     CurrencyFormat.convertToIdr(
                                          //         inireport['keuntungan'], 0),
                                          //     style: TextStyle(
                                          //         fontWeight: FontWeight.bold,
                                          //         fontSize: 15)),

                                          Text(
                                              CurrencyFormat.convertToIdr(
                                                  inireport['keuntungan'], 0),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),

                                          // Text(
                                          //     CurrencyFormat.convertToIdr(
                                          //         double.parse(controller.ayam
                                          //             .toString()),
                                          //         0),
                                          //     style: TextStyle(
                                          //         fontWeight: FontWeight.bold,
                                          //         fontSize: 15)),
                                          // Text(controller.ayam.toString()),
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(''),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('profit'),
                                          SizedBox(width: 5),
                                          Text(
                                            "(" +
                                                formatter.format(inireport[
                                                    'persentase_profit']) +
                                                ") %",
                                          )
                                        ],
                                      ),

                                      Text(
                                          CurrencyFormat.convertToIdr(
                                              inireport['realisasi'], 0),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(''),
                                      Text('total equity'),
                                      Text(
                                          CurrencyFormat.convertToIdr(
                                              inireport['total_semua'], 0),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )));
                  },
                );
              }),
            ),
            Container(
              height: screenHeight * 0.495,
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
                  itemCount: controller.PortoSemua.length,
                  itemBuilder: (context, index) {
                    final allPorto = controller.PortoSemua[index];
                    final keuntungan =
                        controller.PortoSemua[index]['keuntungan'];
                    //  final penutupan = controller.companies[index];
                    //final inireport = controller.report[index];
                    // final inireport = controller.report[index];
                    // print(allPorto);
                    // print("ini keuntungan " + keuntungan.toString());

                    // num totalkeuntungan = 0;
                    // for (var data in controller.PortoSemua) {
                    //   totalkeuntungan += data['keuntungan'];
                    // }

                    // print('keuntungan nilai: $totalkeuntungan');

                    return Card(
                        color: secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                            splashColor: Colors.redAccent.withAlpha(30),
                            onTap: () {
                              Get.toNamed(Routes.PORTO_ALL_DETAIL, arguments: {
                                'nama_saham': allPorto['nama_saham'],
                                'year': allPorto['year'],
                                'harga_close': allPorto['harga_close'],
                                'total_banget': allPorto['total_banget'],
                                'keuntungan': allPorto['keuntungan'],
                                // 'year': inireport['year'].toString(),
                              });
                            },
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
                                      Text(allPorto['nama_saham'].toString(),
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
                                      //     Text('keuntungan'),
                                      //     // Text(time?.toString() ?? "Empty"),
                                      //     Text(
                                      //       // CurrencyFormat.convertToIdr(
                                      //       //     allPorto['sisa_aset'], 0),
                                      //       "Rp." +
                                      //           formatter.format(double.parse(
                                      //               allPorto['keuntungan']
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
                                      //     Text('realisasi'),
                                      //     // Text(time?.toString() ?? "Empty"),
                                      //     Text(
                                      //       // CurrencyFormat.convertToIdr(
                                      //       //     allPorto['sisa_aset'], 0),
                                      //       "Rp." +
                                      //           formatter.format(double.parse(
                                      //               allPorto['sisa_aset']
                                      //                   .toString())),
                                      //       // allPorto['keuntungan'].toString(),
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.w600,
                                      //           fontSize: 14),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: 200,
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('floating return'),
                                          // Text(time?.toString() ?? "Empty"),
                                          Text(
                                            // CurrencyFormat.convertToIdr(
                                            //     allPorto['sisa_aset'], 0),
                                            "Rp " +
                                                formatter.format(double.parse(
                                                    allPorto['keuntungan']
                                                        .toString())),
                                            // allPorto['keuntungan'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('equity'),
                                          // Text(time?.toString() ?? "Empty"),
                                          Text(
                                            // CurrencyFormat.convertToIdr(
                                            //     allPorto['sisa_aset'], 0),
                                            "Rp " +
                                                formatter.format(double.parse(
                                                    allPorto['total_banget']
                                                        .toString())),
                                            // allPorto['keuntungan'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
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
                                          Text('lot total'),
                                          Text(
                                              formatter.format(double.parse(
                                                  allPorto['total_volume'])),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)),
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
                                                  allPorto[
                                                      'total_volume_beli'])),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)),
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
                                                  allPorto['total_volume_jual']
                                                      .toString())),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)),
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
                                                  allPorto['avg_harga_beli'])),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                // color: Colors.black87,
                                                fontSize: 13,
                                                // color: double.parse(penutupan[
                                                //             'close']) <
                                                //         double.parse(allPorto[
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
                                                  allPorto['avg_harga_jual']
                                                      .toString())),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                // color: Colors.black87,
                                                fontSize: 13,
                                                // color: double.parse(penutupan[
                                                //             'close']) >
                                                //         double.parse(allPorto[
                                                //                 'avg_harga_jual']
                                                //             .toString())
                                                //     ? Colors.green[400]
                                                //     : Colors.red[400]
                                              )),
                                          // Text(
                                          //   allPorto['avg_harga_jual'].toString(),
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.w600,
                                          //       fontSize: 16,
                                          //       color: double.parse(
                                          //                   penutupan['close']) >
                                          //               double.parse(
                                          //                   allPorto['avg_harga_jual']
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
                                            //     allPorto['sisa_aset'], 0),

                                            formatter.format(double.parse(
                                                allPorto['harga_close']
                                                    .toString())),
                                            //  allPorto['sisa_aset'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )));
                  },
                );
              }),
            ),
            Container(
              // height: screenHeight * 0.01,
              color: primary,
              margin: EdgeInsets.only(left: 5, top: 4),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '*Data tidak realtime (Berdasarkan close hari sebelumnya)',
                    style: TextStyle(
                        // fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Colors.black87),
                  ),
                  // Text(time?.toString() ?? "Empty"),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
