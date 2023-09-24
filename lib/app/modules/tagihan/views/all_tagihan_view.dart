import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/modules/porto/views/porto_jual_view.dart';
import 'package:stock_app/app/modules/tagihan/views/history_view.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/tagihan_controller.dart';
import 'tagihan_view.dart';

class AllTagihanView extends GetView<TagihanController> {
  AllTagihanView({Key? key}) : super(key: key);
  TagihanController controller = Get.put(TagihanController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                          "Tagihan",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: Colors.black87),
                        )),
                    Container(
                      width: Get.width / 7,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // controller.logout();
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 24.0,
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TabBar(
                    indicatorColor: Colors.green[200],
                    indicatorWeight: 2,
                    tabs: [
                      Tab(
                          child: Text(
                        "Pending",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                      Tab(
                          child: Text(
                        "History",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    TagihanView(),
                    HistoryView(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
