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

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/subscribe_controller.dart';
import 'subscribe_view2.dart';

class SubscribeAndPostView extends GetView<SubscribeController> {
  SubscribeAndPostView({Key? key}) : super(key: key);
  SubscribeController controller = Get.put(SubscribeController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .AmbilAnalyst(); // Replace this with your actual data-fetching logic.
  }

  // var role = ''.obs;
  @override
  Widget build(BuildContext context) {
    //List<dynamic> PlanKu = controller.MyPlan;

    return DefaultTabController(
        length: 4,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: Scaffold(
            backgroundColor: primary,
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Analyst",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Colors.black87),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 20),
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     controller.role.value,
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: 30,
                      //         color: Colors.black87),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() => controller.role == "Analyst"
                              ? Container(
                                  width: Get.width / 4,
                                  margin: EdgeInsets.only(top: 20),
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      // print(controller.id_analyst.value);
                                      // controller.PlanManage();
                                      Get.toNamed(Routes.PLAN, arguments: {
                                        // 'price': controller.MyPlan['price'],
                                        // 'month': controller.MyPlan[3],
                                      });
                                    },
                                    icon: Icon(
                                      Icons.edit_note,
                                      size: 24.0,
                                      color: black,
                                    ),
                                  ),
                                )
                              : SizedBox()),
                          // Container(
                          //   width: Get.width / 10,
                          //   margin: EdgeInsets.only(top: 20),
                          //   alignment: Alignment.centerRight,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       // controller.logout();
                          //     },
                          //     icon: Icon(
                          //       Icons.notifications,
                          //       size: 24.0,
                          //       color: black,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                      indicatorColor: Colors.green[200],
                      indicatorWeight: 4,
                      isScrollable: true,
                      tabs: [
                        Tab(
                            child: Text(
                          "Subscribed",
                          style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black87),
                        )),
                        Tab(
                            child: Text(
                          "Name",
                          style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black87),
                        )),
                        Tab(
                            child: Text(
                          "Post",
                          style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black87),
                        )),
                        Obx(
                          () => controller.role.value == "Analyst"
                              ? Tab(
                                  child: Text(
                                  "Mine",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                ))
                              : SizedBox(),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(
                    children: [
                      SubscribedView(),
                      SubscribeView2(),
                      PublicPostView(),
                      MinePostView(),
                    ],
                  )),
                ],
              ),
            ),
            floatingActionButton: Obx(() => controller.role.value == "Analyst"
                ? FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Routes.POST);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.brown,
                  )
                : SizedBox()),
          ),
        ));
  }
}
