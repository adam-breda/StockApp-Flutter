import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/subscribe_controller.dart';

class PublicPostView extends GetView<PublicPostController> {
  PublicPostView({Key? key}) : super(key: key);
  PublicPostController controller = Get.put(PublicPostController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchPublicPost(); // Replace this with your actual data-fetching logic.
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
          backgroundColor: primary,
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      itemCount: controller.publicpost.length,
                      itemBuilder: (context, index) {
                        final publicposts = controller.publicpost[index];

                        return InkWell(
                          splashColor: Colors.redAccent.withAlpha(30),
                          onTap: () {
                            Get.toNamed(Routes.PUBLIC_POST_DETAIL, arguments: {
                              'id_post': publicposts['id_post'],
                              'title': publicposts['title'],
                              'content': publicposts['content'],
                              'picture': publicposts['picture'],
                              'id_user': publicposts['id_user'],
                              'id_saham': publicposts['id_saham'],
                              'tag': publicposts['tag'],
                              'name': publicposts['name'],
                              'created_at': publicposts['created_at'],
                              'updated_at': publicposts['updated_at'],
                            });
                          },
                          child: Container(
                              width: Get.width * .5,
                              margin: EdgeInsets.only(bottom: 30),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      // spreadRadius: 2,
                                      //   blurRadius: 0.1,
                                      offset: Offset(0, 1.5),
                                    ),
                                  ],
                                  color: secondary,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.network(
                                      //   publicposts['picture'],
                                      //   width: Get.width,
                                      //   //height: Get.height,
                                      // ),
                                      // Text(
                                      //   publicposts['picture'],
                                      //   maxLines: 3,
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Expanded(
                                        child: Container(
                                          width: Get.width * 0.81,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image.network(
                                              //   publicposts['picture'].toString(),
                                              //   width: Get.width,
                                              //   //height: Get.height,
                                              // ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: Get.width * 0.76,
                                                child: Text(
                                                  publicposts['title'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17,
                                                      color: Colors
                                                          .redAccent[400]),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: Get.width * 0.76,
                                                child: Text(
                                                  publicposts['content'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              // GestureDetector(
                                              //   // onTap: () {
                                              //   //   _launchURL(
                                              //   //       'https://www.google.com/'); // Ganti dengan URL yang Anda inginkan
                                              //   // },
                                              //   onTap: () {
                                              //     _launchURL(publicposts[
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
                                              //   // publicposts['url']
                                              //   child: Text(
                                              //     "...read more",
                                              //     style: TextStyle(
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.bold,
                                              //       color: Colors.blue,
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "by " +
                                                          publicposts['name'],
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 65,
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 4,
                                                        bottom: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: publicposts[
                                                                    'tag'] ==
                                                                'private'
                                                            ? Colors.redAccent
                                                                .withOpacity(.2)
                                                            : Colors.green
                                                                .withOpacity(
                                                                    .2)),
                                                    child: Text(
                                                      publicposts['tag'],
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                  // Container(
                                                  //   child: Text(
                                                  //     publicposts['tag'].toString(),
                                                  //     style: TextStyle(
                                                  //         fontSize: 11,
                                                  //         fontWeight:
                                                  //             FontWeight.w400),
                                                  //   ),
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Icon(
                                      //       Icons.monetization_on,
                                      //       size: 16,
                                      //       color: Colors.redAccent[400],
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     Text(
                                      //         style: TextStyle(
                                      //             color: Colors.redAccent[400],
                                      //             fontWeight: FontWeight.bold,
                                      //             fontSize: 15),
                                      //         // formatter.format(double.parse(
                                      //         publicposts['subscribe_fee'].toString()
                                      //         //  )
                                      //         // ),
                                      //         )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       Get.toNamed(Routes.publicposts_PAGE,
                                  //           arguments: {'publicposts': publicposts});
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: Colors.redAccent[400],
                                  //       minimumSize: Size(80, 36),
                                  //       padding: EdgeInsets.symmetric(horizontal: 5),
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(5.0),
                                  //       ),
                                  //     ),
                                  //     child: Row(
                                  //       children: [
                                  //         Icon(Icons.visibility),
                                  //         SizedBox(
                                  //           width: 10,
                                  //         ),
                                  //         Text(
                                  //           "View",
                                  //           style: TextStyle(fontSize: 14),
                                  //         ),
                                  //       ],
                                  //     ))
                                ],
                              )),
                        );
                      });
                }))
              ],
            ),
          )),
    );
  }
}
