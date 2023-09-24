import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stock_app/app/modules/dashboard/views/technical_backup_view.dart';
import 'package:stock_app/app/modules/dashboard/views/technical_view.dart';
import 'package:stock_app/app/modules/dashboard/views/toploser_view.dart';
import 'package:stock_app/app/modules/dashboard/views/trend_view.dart';
import 'package:stock_app/app/routes/app_pages.dart';

import '../../../Values/values.dart';
import '../controllers/dashboard_controller.dart';
import 'detail_technical_view.dart';
import 'tren_view.dart';
import 'topgainer_view.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: primary,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                    alignment: Alignment.centerLeft,
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.toNamed(Routes.PROFILE);
                            //   },
                            Container(
                              child: Text(
                                controller.name.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                    color: Colors.black87),
                              ),
                            ),
                            // ),
                            // Container(

                            // ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[200],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  controller.role.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                            )
                          ],
                        ))),
                SizedBox(
                  height: 15,
                ),
                TabBar(
                    indicatorColor: Colors.green[200],
                    indicatorWeight: 2.5,
                    isScrollable: true,
                    // unselectedLabelColor: Colors.black87,
                    labelColor: Colors.black87,
                    tabs: [
                      Tab(
                          child: Text(
                        "Trending",
                        style: TextStyle(
                          // fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      )),
                      Tab(
                          child: Text(
                        "Tren",
                        style: TextStyle(
                          // fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      )),
                      Tab(
                          child: Text(
                        "Top Gainer",
                        style: TextStyle(
                          // fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      )),
                      Tab(
                          child: Text(
                        "Top Loser",
                        style: TextStyle(
                          // fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      )),
                      // Tab(
                      //     child: Text(
                      //   "Technical",
                      //   style: TextStyle(
                      //     // fontWeight: FontWeight.w900,
                      //     fontSize: 15,
                      //   ),
                      // )),
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    //listing
                    TrendView(),
                    TrenView(),
                    //news
                    TopGainerView(),
                    TopLoserView(),
                    // TechnicalView(
                    //   inputHistory: [],
                    // ),
                    //TechnicalBackupView()
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
