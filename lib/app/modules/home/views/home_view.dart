import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stock_app/app/modules/listing_news/views/listing_news_view.dart';
import 'package:stock_app/app/modules/porto/views/porto_view.dart';
import 'package:stock_app/app/modules/profile/views/profile_view.dart';
import 'package:stock_app/app/modules/subscribe/views/subscribe_view.dart';

import '../../../Values/values.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../subscribe/views/subscribe_and_post_view.dart';
import '../../tagihan/views/all_tagihan_view.dart';
import '../../tagihan/views/tagihan_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  final List<Widget> _pages = [
    DashboardView(),
    PortoView(),
    SubscribeAndPostView(),
    ListingNewsView(),
    // AllTagihanView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _pages[controller.selectedIndex.value]),
        bottomNavigationBar: SizedBox(
            height: 80,
            child: Obx(
              () => BottomNavigationBar(
                backgroundColor: primary,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, color: Colors.black87),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined, color: Colors.black87),
                    label: 'Portofolio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.subscriptions_outlined,
                        color: Colors.black87),
                    label: 'Analyst',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart, color: Colors.black87),
                    label: 'Stock',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.notifications_outlined,
                  //       color: Colors.black87),
                  //   label: 'Notification',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline, color: Colors.black87),
                    label: 'Profile',
                  ),
                ],
                currentIndex: controller.selectedIndex.value,
                // selectedItemColor: Colors.green[400],
                selectedItemColor: Colors.green[400],
                onTap: (int index) {
                  controller.selectedIndex.value = index;
                },
              ),
            )));
  }
}
