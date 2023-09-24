import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../widgets/DetailValuation.dart';
import '../controllers/porto_controller.dart';

class PortoJualView extends GetView<PortoController> {
  PortoJualView({Key? key}) : super(key: key);
  PortoController controller = Get.put(PortoController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchJual(); // Replace this with your actual data-fetching logic.
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
              itemCount: controller.jualPortos.length,
              itemBuilder: (context, index) {
                final jualPorto = controller.jualPortos[index];
                final penutupan = controller.companies[index];
                final valueChange = penutupan['change'];

                // if (jualPorto.isDataEmpty) {
                //   return Container(
                //     width: Get.width * 0.97,
                //     height: 210,
                //     child: SingleChildScrollView(
                //       child: DetailValuation(),
                //     ),
                //   );
                // } else {
                return Card(
                    color: secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                        onTap: () {
                          controller.idPortofolioJualC.text =
                              jualPorto['id_portofolio_jual'].toString();
                          controller.volumeC.text =
                              jualPorto['volume'].toString();
                          controller.hargaJualC.text =
                              jualPorto['harga_jual'].toString();
                          controller.tanggalJualC.text =
                              jualPorto['tanggal_jual'].toString();
                          controller.jenisSahamC.text =
                              jualPorto['jenis_saham'].toString();
                          Get.defaultDialog(
                              backgroundColor: primary,
                              title: 'Saham ${jualPorto['nama_saham']}',
                              titlePadding: EdgeInsets.all(20),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.centerLeft,
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
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13.0),
                                                      hintText:
                                                          'Masukkan volume jual',
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
                                                Text("Harga Jual"),
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
                                                        controller.hargaJualC,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13.0),
                                                      hintText:
                                                          'Masukkan harga jual',
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
                                        Text("Tanggal Jual"),
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
                                            controller: controller.tanggalJualC,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(fontSize: 13.0),
                                              hintText: 'Masukkan tanggal jual',
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
                                              height: 5,
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
                                                // decoration: InputDecoration(
                                                //   labelText:
                                                //       'Pilih fundamental', // Label untuk dropdown
                                                // ),
                                                //  Text(beliPorto['nama_saham'].toString(),
                                              ),
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
                                            Obx(() => Container(
                                                width: Get.width / 3,
                                                child: controller
                                                            .isSending.value ==
                                                        false
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                fixedSize: Size(
                                                                    200, 40),
                                                                // shape: StadiumBorder(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green),
                                                        onPressed: () {
                                                          controller.saveTransactionJual(
                                                              jualPorto[
                                                                      'id_portofolio_jual']
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
                                                                fixedSize: Size(
                                                                    200, 40),
                                                                // shape: StadiumBorder(),e
                                                                backgroundColor:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          controller.deleteJual(
                                                              jualPorto[
                                                                  'id_portofolio_jual']);
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
                                  Text(jualPorto['nama_saham'].toString(),
                                      style: TextStyle(
                                          // color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color:
                                              double.parse(penutupan['close']) >
                                                      jualPorto['harga_jual']
                                                  ? Colors.green[400]
                                                  : Colors.red[400])),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Sale Date : " +
                                              jualPorto['tanggal_jual'],
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
                                            // (jualPorto['total_jual'])
                                            //     .toString(),
                                            "Rp." +
                                                formatter.format(double.parse(
                                                    (jualPorto['total_jual'])
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
                                        jualPorto['nama_sekuritas'].toString(),
                                        style: TextStyle(
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
                                            jualPorto['harga_jual'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: double.parse(penutupan[
                                                            'close']) >
                                                        jualPorto['harga_jual']
                                                    ? Colors.green[400]
                                                    : Colors.red[400]),
                                          )
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
                                            jualPorto['volume'].toString(),
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
