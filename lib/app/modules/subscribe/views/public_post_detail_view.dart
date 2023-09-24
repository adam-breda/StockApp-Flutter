import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/Values/values.dart';

import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/public_post_detail_controller.dart';
import '../controllers/subscribe_controller.dart';

class PublicPostDetailView extends GetView<PublicPostDetailController> {
  PublicPostDetailView({Key? key}) : super(key: key);
  PublicPostDetailController controller = Get.put(PublicPostDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          title: Text(
            // controller.arguments['name'].toString(),
            "Post",
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
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent[400],
            ));
          }

          //Map<String, dynamic> dataa = controller.news;
          //print(dataa);
          final formatter = NumberFormat('#,###');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Card(
                    color: primary,
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
                              width: Get.width * 0.81,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.network(
                                  //   controller.arguments['urlToImage'],
                                  //   width: Get.width,
                                  //   //height: Get.height,
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    controller.arguments['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color: Colors.redAccent[400]),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: Text(
                                      controller.arguments['content'],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        // wordSpacing: 2,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   // onTap: () {
                                  //   //   _launchURL(
                                  //   //       'https://www.google.com/'); // Ganti dengan URL yang Anda inginkan
                                  //   // },
                                  //   onTap: () {
                                  //     _launchURL(controller.arguments[
                                  //         'url']); // Ganti dengan URL yang Anda inginkan
                                  //   },
                                  //   child: Text(
                                  //     '...read more',
                                  //     style: TextStyle(
                                  //       decoration: TextDecoration.underline,
                                  //       color: Colors.blue,
                                  //       fontSize: 12,
                                  //     ),
                                  //   ),
                                  // ),

                                  // Container(
                                  //   // controller.arguments['url']
                                  //   child: Text(
                                  //     "...read more",
                                  //     style: TextStyle(
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.blue,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  // Container(
                                  //   child: Text(
                                  //     "published at " +
                                  //         controller.arguments['publishedAt'],
                                  //     style: TextStyle(
                                  //         fontSize: 10,
                                  //         fontWeight: FontWeight.w400),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                    // child: Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 controller.arguments['content'],
                    //                 overflow: TextOverflow.ellipsis,
                    //                 //controller.arguments['title'],
                    //                 //print(data),
                    //                 style: TextStyle(
                    //                     fontSize: 25,
                    //                     height: 2,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Colors.redAccent[400]),
                    //               ),
                    //               // SizedBox(height: 10),

                    //               // Text(
                    //               //   controller.arguments['content'],
                    //               //   style: TextStyle(color: Colors.black54),
                    //               // )
                    //             ],
                    //           ),
                    //           // Container(
                    //           //   width: 70,
                    //           //   height: 70,
                    //           //   child: Image.network(
                    //           //     controller.arguments['urlToImage'],
                    //           //     //data['urlToImage'],
                    //           //     width: 70,
                    //           //     height: 70,
                    //           //   ),
                    //           // )
                    //         ],
                    //       ),
                    //       Divider(
                    //         color: Colors.black38,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}

// _launchURL(String url) async {
//   if (!await canLaunch(url)) {
//     await launch(
//       url,
//       forceSafariVC: false,
//       forceWebView: false,
//       headers: <String, String>{'my_header_key': 'my_header_value'},
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }
