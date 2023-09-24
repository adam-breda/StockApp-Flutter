import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/analyst_page_controller.dart';

class AnalystPageView extends GetView<AnalystPageController> {
  AnalystPageView({Key? key}) : super(key: key);
  AnalystPageController controller = Get.put(AnalystPageController());

  @override
  Widget build(BuildContext context) {
    final analyst = controller.arguments['analyst'];
    print(analyst);
    return Scaffold(
        // backgroundColor: Colors.redAccent[400],
        body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    analyst['name'],
                    style: TextStyle(
                        color: Colors.redAccent[400],
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    analyst['email'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Obx(() => controller.alreadySubscribe == 'false'
                  ? ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: 'Subscribe',
                            titlePadding: EdgeInsets.all(20),
                            content: Column(
                              children: [
                                Text(
                                    "Subscribe Fee : ${analyst['subscribe_fee']}"),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.subscribe();
                                  },
                                  child: Text("Subscribe"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent[400],
                                    // minimumSize: Size(80, 36),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                )
                              ],
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent[400],
                        minimumSize: Size(80, 36),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: Text(
                        "Subscribe",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        controller.unsubscribe();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(80, 36),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: Text(
                        "Unsubscribe",
                        style: TextStyle(
                            fontSize: 12, color: Colors.redAccent[400]),
                      ),
                    ))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(child: Obx(() {
            if (controller.isLoading.value == true) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.redAccent[400],
              ));
            }
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.portos.length,
              itemBuilder: (context, index) {
                final porto = controller.portos[index];
                final inputString = porto['tanggal'];
                final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                final outputFormat = DateFormat('dd MMM yyyy');

                final date = inputFormat.parse(inputString);
                final formattedDate = outputFormat.format(date);
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // width: Get.width * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  porto['id_saham'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: porto['type'] == 'beli'
                                        ? Colors.green[400]
                                        : Colors.red[400],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Harga ${porto['type']} : ${porto['harga']}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      'Volume : ${porto['volume']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Text(
                                      'Fee : ${porto['fee']} %',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ))
                                  ],
                                ),
                                controller.alreadySubscribe == 'true' &&
                                        porto['comment'] != ' '
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            "Comment : ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            porto['comment'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.redAccent[400]),
                                          )
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: porto['type'] == 'beli'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                porto['type'].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          }))
        ],
      ),
    ));
  }
}
