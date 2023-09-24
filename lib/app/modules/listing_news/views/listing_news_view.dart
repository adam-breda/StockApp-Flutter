import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';

import 'package:stock_app/app/modules/porto/views/porto_view.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../../listing/views/listing_view.dart';
import '../../news/views/news_view.dart';
import '../controllers/listing_news_controller.dart';

class ListingNewsView extends GetView<ListingNewsController> {
  ListingNewsView({Key? key}) : super(key: key);
  ListingNewsController controller = Get.put(ListingNewsController());

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max, priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notifikasi',
      'Ini adalah contoh notifikasi',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primary,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 150),
                        alignment: Alignment.center,
                        child: Text(
                          "STOCK APP",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black87),
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      //width: Get.width / 4,

                      margin: EdgeInsets.only(top: 20, right: 10),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // print(controller.id_analyst.value);
                          // controller.PlanManage();
                          Get.toNamed(Routes.TECHNICAL, arguments: {
                            // 'price': controller.MyPlan['price'],
                            // 'month': controller.MyPlan[3],
                          });
                        },
                        icon: Icon(
                          Icons.insights,
                          size: 24.0,
                          color: black,
                        ),
                      ),
                    ),
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
            TabBar(
                indicatorColor: Colors.green[200],
                indicatorWeight: 3,
                tabs: [
                  Tab(
                      child: Text(
                    "Stock",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  )),
                  Tab(
                      child: Text(
                    "News",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  )),
                ]),
            Expanded(
                child: TabBarView(
              children: [
                ListingView(),
                NewsView(),
              ],
            ))
          ],
        ),
      ),
      // backgroundColor: Colors.grey[200],
      // body: Obx(() => _pages[controller.selectedIndex.value]),
      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.book_outlined),
      //         label: 'efef',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.monetization_on_outlined),
      //         label: 'Stock',
      //       ),
      //     ],
      //     currentIndex: controller.selectedIndex.value,
      //     selectedItemColor: Colors.redAccent[400],
      //     onTap: (int index) {
      //       controller.selectedIndex.value = index;
      //     },
      //   ),
      // )
    );
  }
}
