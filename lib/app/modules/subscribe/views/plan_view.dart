import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/modules/subscribe/views/mine_post_view.dart';
import 'package:stock_app/app/modules/subscribe/views/public_post_view.dart';
import 'package:stock_app/app/modules/subscribe/views/subscribe_view.dart';
import 'package:stock_app/app/modules/subscribe/views/subscribed_view.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/plan_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanView extends GetView<PlanController> {
  PlanView({Key? key}) : super(key: key);
  PlanController controller = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          "My Plan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent[400],
                    ),
                  );
                }
                final formatter = NumberFormat('#,###');

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 5); // Atur jarak antar Card di sini
                  },
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.MyPlan.length,
                  itemBuilder: (context, index) {
                    final PlanKu = controller.MyPlan[index];

                    return Card(
                      color: secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //margin: margin(bottom: 10.0),
                      child: InkWell(
                        splashColor: Colors.redAccent.withAlpha(30),
                        onTap: () {
                          // Handle card tap here if needed
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CurrencyFormat.convertToIdr(
                                      PlanKu['price'],
                                      0,
                                    ),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${PlanKu['month']} Month',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(() => Container(
                                        width: Get.width / 8,
                                        child: controller.isSending.value ==
                                                false
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  fixedSize: Size(100, 20),
                                                  backgroundColor: Colors.green,
                                                ),
                                                onPressed: () {
                                                  // Handle edit button press
                                                  controller.priceC.text =
                                                      PlanKu['price']
                                                          .toString();
                                                  controller.monthC.text =
                                                      PlanKu['month']
                                                          .toString();

                                                  Get.defaultDialog(
                                                    backgroundColor: primary,
                                                    title: "EDIT PLAN",
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text("Price"),
                                                            SizedBox(height: 5),
                                                            Container(
                                                              width: Get.width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: TextField(
                                                                controller:
                                                                    controller
                                                                        .priceC,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              13.0),
                                                                  hintText:
                                                                      'Add Price',
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          11.0),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          16.0,
                                                                      vertical:
                                                                          12.0),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text("Month"),
                                                            SizedBox(height: 5),
                                                            Container(
                                                              width: Get.width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: TextField(
                                                                controller:
                                                                    controller
                                                                        .monthC,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              13.0),
                                                                  hintText:
                                                                      'Add Month',
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          11.0),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          16.0,
                                                                      vertical:
                                                                          12.0),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Obx(() =>
                                                                    Container(
                                                                      width:
                                                                          Get.width /
                                                                              3,
                                                                      child: controller.isSending.value ==
                                                                              false
                                                                          ? ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                                fixedSize: Size(200, 40),
                                                                                backgroundColor: Colors.green,
                                                                              ),
                                                                              onPressed: () {
                                                                                // Handle update button press
                                                                                controller.updateMyPlan(PlanKu['id_price'].toString());
                                                                              },
                                                                              child: Text("Update"),
                                                                            )
                                                                          : Center(
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                    )),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.black87,
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Obx(() => Container(
                                        width: Get.width / 8,
                                        child: controller.isSending.value ==
                                                false
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  fixedSize: Size(100, 20),
                                                  backgroundColor: Colors.red,
                                                ),
                                                onPressed: () {
                                                  // Handle delete button press
                                                  controller.deleteMyPlan(
                                                      PlanKu['id_price']);
                                                },
                                                child: Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.black87,
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_PLAN);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
