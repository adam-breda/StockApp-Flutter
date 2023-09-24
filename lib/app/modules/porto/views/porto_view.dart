import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/modules/porto/views/porto_all_view.dart';
import 'package:stock_app/app/modules/porto/views/porto_jual_view.dart';
import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/porto_controller.dart';
import 'porto_beli_view.dart';

class PortoView extends GetView<PortoController> {
  PortoView({Key? key}) : super(key: key);
  PortoController controller = Get.put(PortoController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
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
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 33),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Portofolio",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: Colors.black87),
                        )),
                    // Container(
                    //   width: Get.width / 7,
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
                SizedBox(
                  height: 20,
                ),
                TabBar(
                    indicatorColor: Colors.green[200],
                    indicatorWeight: 3,
                    tabs: [
                      Tab(
                          child: Text(
                        "Semua",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                      Tab(
                          child: Text(
                        "Beli",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                      Tab(
                          child: Text(
                        "Jual",
                        style: TextStyle(
                            // fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.black87),
                      )),
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    PortoAllView(),
                    PortoBeliView(),
                    PortoJualView(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
