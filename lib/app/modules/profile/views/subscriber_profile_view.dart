import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_report_controller.dart';
import '../controllers/subscriber_profile_controller.dart';
import 'profile_view.dart';
import '../../porto/controllers/porto_controller.dart';

class SubscriberProfileView extends GetView<SubscriberProfileController> {
  SubscriberProfileView({Key? key}) : super(key: key);
  SubscriberProfileController controller =
      Get.put(SubscriberProfileController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    // await controller
    //     .Report(); // Replace this with your actual data-fetching logic.
    // await controller.ReportHistory();
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
            "Subscriber",
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
                    itemCount: controller.Subscriber.length,
                    itemBuilder: (context, index) {
                      final SubscriberDetail = controller.Subscriber[index];
                      //final penutupan = controller.companies[index];
                      //final inireport = controller.report[index];
                      // final inireport = controller.report[index];
                      //print(HistoryReport);
                      DateTime expiredDate =
                          DateTime.parse(SubscriberDetail['expired']);
                      // Get the current date as a DateTime object
                      DateTime currentDate = DateTime.now();

                      // Calculate the difference between the "expired" date and the current date
                      Duration difference = expiredDate.difference(currentDate);

                      // Calculate the number of days left until the "expired" date
                      int daysLeft = difference.inDays;

                      return Card(
                          color: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                              splashColor: Colors.redAccent.withAlpha(30),
                              // onTap: () {
                              //   Get.toNamed(Routes.DETAIL_ANALYST,
                              //       arguments: {
                              //         'id': SubscriberDetail['id'],
                              //         'name': SubscriberDetail['name'],
                              //         'email': SubscriberDetail['email'],
                              //         // 'nama_saham': allPorto['nama_saham'],
                              //         // 'total_volume_beli': allPorto['total_volume_beli'],
                              //         // 'avg_harga_beli': allPorto['url'],
                              //         // 'total_volume_jual': allPorto['total_volume_jual'],
                              //         // 'avg_harga_jual': allPorto['avg_harga_jual'],
                              //       });
                              // },
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
                                        Text(SubscriberDetail['name'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        Text(
                                            SubscriberDetail['status']
                                                .toString(),
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                        // Text(SubscriberDetail['id'].toString(),
                                        //     style: TextStyle(
                                        //         // fontWeight: FontWeight.bold,
                                        //         fontSize: 13)),
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
                                            Text(SubscriberDetail['email'],
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Days left: $daysLeft",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 10)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
