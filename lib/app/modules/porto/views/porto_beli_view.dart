import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../Values/values.dart';
import '../controllers/porto_controller.dart';

class PortoBeliView extends GetView<PortoController> {
  PortoBeliView({Key? key}) : super(key: key);
  PortoController controller = Get.put(PortoController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchBeli(); // Replace this with your actual data-fetching logic.
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        body: Container(
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
              padding: EdgeInsets.only(top: 10.0),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.beliPortos.length,
              itemBuilder: (context, index) {
                final beliPorto = controller.beliPortos[index];
                final penutupan = controller.companies[index];
                final valueChange = penutupan['change'];
                //  final formatter = StringFormatt;

                return Card(
                    color: secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                        splashColor: Colors.redAccent.withAlpha(30),
                        onTap: () {
                          controller.idPortofolioBeliC.text =
                              beliPorto['id_portofolio_beli'].toString();
                          controller.volumeC.text =
                              beliPorto['volume'].toString();
                          controller.hargaBeliC.text =
                              beliPorto['harga_beli'].toString();
                          controller.tanggalBeliC.text =
                              beliPorto['tanggal_beli'].toString();
                          controller.jenisSahamC.text =
                              beliPorto['jenis_saham'].toString();
                          // controller.selectedValueSekuritas =
                          //     beliPorto['nama_sekuritas'].toString();

                          Get.defaultDialog(
                              backgroundColor: primary,
                              title: 'Saham ${beliPorto['nama_saham']}',
                              titlePadding: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 20),
                              content: SingleChildScrollView(
                                //padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    // height: 400,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(8.0),
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Volume"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: TextField(
                                                    controller:
                                                        controller.volumeC,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13.0),
                                                      hintText:
                                                          'Masukkan volume beli',
                                                      hintStyle: TextStyle(
                                                          fontSize: 11.0),
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 12.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Harga Beli"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: TextField(
                                                    controller:
                                                        controller.hargaBeliC,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13.0),
                                                      hintText:
                                                          'Masukkan harga beli',
                                                      hintStyle: TextStyle(
                                                          fontSize: 11.0),
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 12.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("Tanggal Beli"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextField(
                                            controller: controller.tanggalBeliC,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(fontSize: 13.0),
                                              hintText: 'Masukkan tanggal beli',
                                              hintStyle:
                                                  TextStyle(fontSize: 11.0),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   width: Get.width,
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.grey[300],
                                        //   ),
                                        //   child: TextField(
                                        //     controller: controller.sekuritasC,
                                        //     decoration: InputDecoration(
                                        //       labelStyle:
                                        //           TextStyle(fontSize: 13.0),
                                        //       hintText: 'Masukkan tanggal beli',
                                        //       hintStyle:
                                        //           TextStyle(fontSize: 11.0),
                                        //       border: InputBorder.none,
                                        //       contentPadding:
                                        //           EdgeInsets.symmetric(
                                        //               horizontal: 16.0,
                                        //               vertical: 12.0),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Sekuritas"),
                                            SizedBox(
                                              height: 0,
                                            ),
                                            Container(
                                              width: 300,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: controller
                                                    .selectedValueSekuritas, // Nilai dropdown yang dipilih

                                                onChanged: (newValue) {
                                                  controller
                                                          .selectedValueSekuritas =
                                                      newValue!; // Mengubah nilai dropdown yang dipilih
                                                },
                                                items: <String>[
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4',
                                                  '5',
                                                  '6',
                                                  '7',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  String text;
                                                  switch (value) {
                                                    case '1':
                                                      text =
                                                          "AJAIB SEKURITAS ASIA";
                                                      break;
                                                    case '2':
                                                      text = "BCA SEKURITAS";
                                                      break;
                                                    case '3':
                                                      text = "BNI SEKURITAS";
                                                      break;
                                                    case '4':
                                                      text =
                                                          "BRI DANAREKSA SEKURITAS";
                                                      break;
                                                    case '5':
                                                      text =
                                                          "CGS-CIMB SEKURITAS INDONESIA";
                                                      break;
                                                    case '6':
                                                      text =
                                                          "HENAN PUTIHRAI SEKURITAS";
                                                      break;
                                                    case '7':
                                                      text =
                                                          "INDO PREMIER SEKURITAS";
                                                      break;

                                                    // Add cases for the other values here
                                                    default:
                                                      text =
                                                          "Unknown"; // Handle unknown values
                                                  }
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                        text), // Teks yang akan ditampilkan pada dropdown
                                                  );
                                                }).toList(),
                                                decoration: InputDecoration(
                                                  labelText:
                                                      '', // Label for the dropdown
                                                ),

                                                // decoration: InputDecoration(
                                                //   labelText:
                                                //       'Pilih fundamental', // Label untuk dropdown
                                                // ),
                                                //  Text(beliPorto['nama_saham'].toString(),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(16.0),
                                            //   child: TextField(
                                            //     controller:
                                            //         controller.sekuritasC,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() => Container(
                                                width: Get.width / 3,
                                                child: controller
                                                            .isSending.value ==
                                                        false
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                fixedSize: Size(
                                                                    200, 40),
                                                                // shape: StadiumBorder(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green),
                                                        onPressed: () {
                                                          controller.saveTransactionBeli(
                                                              beliPorto[
                                                                      'id_portofolio_beli']
                                                                  .toString());
                                                        },
                                                        child: Text("Update"))
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ))),
                                            Obx(() => Container(
                                                width: Get.width / 3,
                                                child: controller
                                                            .isSending.value ==
                                                        false
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                fixedSize: Size(
                                                                    200, 40),
                                                                // shape: StadiumBorder(),e
                                                                backgroundColor:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          controller.deleteBeli(
                                                              beliPorto[
                                                                  'id_portofolio_beli']);
                                                        },
                                                        child: Text("Delete"))
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )))
                                          ],
                                        )
                                      ],
                                    )),
                              ));
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
                                  Text(beliPorto['nama_saham'].toString(),
                                      // Text(
                                      //     controller.selectedValueSekuritas
                                      //         .toString(),
                                      style: TextStyle(
                                          //  color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color:
                                              double.parse(penutupan['close']) >
                                                      beliPorto['harga_beli']
                                                  ? Colors.green[400]
                                                  : Colors.red[400])),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Buy Date : " +
                                              beliPorto['tanggal_beli'],
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text(
                                            "Equity : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "Rp." +
                                                formatter.format(double.parse(
                                                    (beliPorto['total_beli'])
                                                        .toString())),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Sekuritas'),
                                      Text(
                                        beliPorto['nama_sekuritas'].toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Price'),
                                          Text(
                                            beliPorto['harga_beli'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: double.parse(penutupan[
                                                            'close']) >
                                                        beliPorto['harga_beli']
                                                    ? Colors.green[400]
                                                    : Colors.red[400]),
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Volume'),
                                          Text(
                                            beliPorto['volume'].toString(),
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
                        )));
              },
            );
          }),
        ),
      ),
    );
  }
}
