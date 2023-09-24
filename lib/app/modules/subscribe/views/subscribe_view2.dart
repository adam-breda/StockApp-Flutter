import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/subscribe_controller.dart';
import '../controllers/subscribe_controller2.dart';

class SubscribeView2 extends GetView<SubscribeController2> {
  SubscribeView2({Key? key}) : super(key: key);
  SubscribeController2 controller = Get.put(SubscribeController2());
  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .AmbilAnalyst(); // Replace this with your actual data-fetching logic.
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
          backgroundColor: primary,
          body: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 60,
                // ),
                // Container(
                //   child: Text(
                //     'Analyst',
                //     style: TextStyle(
                //         color: Colors.redAccent[400],
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(child: Obx(() {
                  if (controller.isLoading.value == true) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.redAccent[400],
                    ));
                  }
                  final formatter = NumberFormat('#,###');

                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      // scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.AnalystStockApp.length,
                      itemBuilder: (context, index) {
                        final analyst = controller.AnalystStockApp[index];

                        return Card(
                            color: secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                                splashColor: Colors.redAccent.withAlpha(30),
                                onTap: () {
                                  Get.toNamed(Routes.SUBS_MIDTRANS, arguments: {
                                    'id': analyst['id'],
                                    'name': analyst['name'],
                                    'email': analyst['email'],
                                    // 'nama_saham': allPorto['nama_saham'],
                                    // 'total_volume_beli': allPorto['total_volume_beli'],
                                    // 'avg_harga_beli': allPorto['url'],
                                    // 'total_volume_jual': allPorto['total_volume_jual'],
                                    // 'avg_harga_jual': allPorto['avg_harga_jual'],
                                  });
                                },
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
                                          Text(analyst['name'],
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
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
                                              Text(analyst['email'],
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )));
                      });
                }))
              ],
            ),
          )),
    );
  }
}