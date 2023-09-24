import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Values/values.dart';
import '../controllers/technical_controller.dart';

class IsiTechnicalView extends GetView<TechnicalController> {
  IsiTechnicalView({Key? key}) : super(key: key);
  TechnicalController controller = Get.put(TechnicalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Technical",
                  style: TextStyle(fontWeight: FontWeight.w900, color: black)),
              // Text(controller.arguments['id'].toString(),
              //     style: TextStyle(
              //         fontWeight: FontWeight.w900, color: black)),
            ],
          ),
          centerTitle: false,
        ),
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent[400],
            ));
          }

          final formatter = NumberFormat('#,###');
          return SingleChildScrollView(
            child: ListView.builder(
              itemCount:
                  controller.HasilTechnical.length, // Jumlah item dalam daftar
              itemBuilder: (context, index) {
                final tabelTechnical = controller.HasilTechnical[index];
                return Card(
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
                                  Text(tabelTechnical['ticker'].toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      )),
                                  // Text(tabelTechnical['tahun'].toString(),
                                  //     style: TextStyle(
                                  //       color: Colors.black87,
                                  //       fontSize: 10,
                                  //       fontWeight: FontWeight.w900,
                                  //     )),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('MA Percentage'),
                                      Text(tabelTechnical['MAPercentage'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('trend'),
                                      Text(tabelTechnical['trend'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('change'),
                                      Text(tabelTechnical['change'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('der'),
                                      Text(tabelTechnical['der'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('ldr'),
                                      Text(tabelTechnical['ldr'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )));
              },
            ),
          );
        }));
  }
}
