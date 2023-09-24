import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/public_post_controller.dart';
import '../controllers/subscribe_controller.dart';

class MinePostView extends GetView<PublicPostController> {
  MinePostView({Key? key}) : super(key: key);
  PublicPostController controller = Get.put(PublicPostController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchMinePost(); // Replace this with your actual data-fetching logic.
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
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.mine.length,
                      itemBuilder: (context, index) {
                        final mineposts = controller.mine[index];

                        return InkWell(
                          splashColor: Colors.redAccent.withAlpha(30),
                          onTap: () {
                            Get.toNamed(Routes.PUBLIC_POST_DETAIL, arguments: {
                              'id_post': mineposts['id_post'],
                              'title': mineposts['title'],
                              'content': mineposts['content'],
                              'picture': mineposts['picture'],
                              'id_user': mineposts['id_user'],
                              'id_saham': mineposts['id_saham'],
                              'tag': mineposts['tag'],
                              'name': mineposts['name'],
                              'created_at': mineposts['created_at'],
                              'updated_at': mineposts['updated_at'],
                            });
                          },
                          child: Container(
                              width: Get.width * .5,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(0, 1.5),
                                    ),
                                  ],
                                  color: secondary,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: Get.width * 0.81,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.65,
                                                    child: Text(
                                                      mineposts['title'],
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
                                                  Container(
                                                    width: 60,
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 4,
                                                        bottom: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: mineposts[
                                                                    'tag'] ==
                                                                'private'
                                                            ? Colors.redAccent
                                                                .withOpacity(.2)
                                                            : Colors.green
                                                                .withOpacity(
                                                                    .2)),
                                                    child: Text(
                                                      mineposts['tag'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: Get.width * 0.76,
                                                child: Text(
                                                  mineposts['content'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "by " + mineposts['name'],
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Obx(() => Container(
                                                          width: Get.width / 8,
                                                          child: controller
                                                                      .isSending
                                                                      .value ==
                                                                  false
                                                              ? ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  10)),
                                                                          fixedSize: Size(
                                                                              100,
                                                                              20),
                                                                          // shape: StadiumBorder(),
                                                                          backgroundColor:
                                                                              Colors.green),
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .tagC
                                                                        .text = mineposts[
                                                                            'tag']
                                                                        .toString();
                                                                    controller
                                                                        .titleC
                                                                        .text = mineposts[
                                                                            'title']
                                                                        .toString();

                                                                    controller
                                                                        .contentC
                                                                        .text = mineposts[
                                                                            'content']
                                                                        .toString();

                                                                    Get.defaultDialog(
                                                                      backgroundColor:
                                                                          primary,
                                                                      title:
                                                                          "EDIT POST",
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        controller:
                                                                            ScrollController(),
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text("Tag"),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Container(
                                                                                    width: Get.width,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.grey[300],
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: DropdownButtonFormField(
                                                                                      items: controller.tagOptions.map((tag) {
                                                                                        return DropdownMenuItem(
                                                                                          value: tag,
                                                                                          child: Text(tag),
                                                                                        );
                                                                                      }).toList(),
                                                                                      value: controller.tagC.text,
                                                                                      onChanged: (value) {
                                                                                        controller.tagC.text = value.toString();
                                                                                      },
                                                                                      decoration: InputDecoration(
                                                                                        labelStyle: TextStyle(fontSize: 13.0),
                                                                                        hintText: 'Pilih tag',
                                                                                        hintStyle: TextStyle(fontSize: 11.0),
                                                                                        border: InputBorder.none,
                                                                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 8,
                                                                                  ),
                                                                                  Text("Title"),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Container(
                                                                                    width: Get.width,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.grey[300],
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: TextField(
                                                                                      controller: controller.titleC,
                                                                                      maxLines: 3,
                                                                                      decoration: InputDecoration(
                                                                                        labelStyle: TextStyle(fontSize: 13.0),
                                                                                        hintText: 'Masukkan title',
                                                                                        hintStyle: TextStyle(fontSize: 11.0),
                                                                                        border: InputBorder.none,
                                                                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 8,
                                                                                  ),
                                                                                  Text("Content"),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  SingleChildScrollView(
                                                                                    controller: ScrollController(),
                                                                                    child: Container(
                                                                                      width: Get.width,
                                                                                      height: 100,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.grey[300],
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                      child: TextField(
                                                                                        controller: controller.contentC,
                                                                                        maxLines: 10,
                                                                                        decoration: InputDecoration(
                                                                                          labelStyle: TextStyle(fontSize: 13.0),
                                                                                          hintText: 'Masukkan content',
                                                                                          hintStyle: TextStyle(fontSize: 11.0),
                                                                                          border: InputBorder.none,
                                                                                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Obx(() => Container(
                                                                                          width: Get.width / 3,
                                                                                          child: controller.isSending.value == false
                                                                                              ? ElevatedButton(
                                                                                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), fixedSize: Size(200, 40), backgroundColor: Colors.green),
                                                                                                  onPressed: () {
                                                                                                    controller.updatePostMine(mineposts['id_post'].toString());
                                                                                                  },
                                                                                                  child: Text("Update"))
                                                                                              : Center(
                                                                                                  child: CircularProgressIndicator(),
                                                                                                ))),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    );
                                                                    // controller.updatePostMine(
                                                                    //     mineposts[
                                                                    //             'id_post']
                                                                    //         .toString());
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: Colors
                                                                          .black87),
                                                                )
                                                              : Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ))),
                                                      SizedBox(
                                                        width: 10.0,
                                                        //   height: 300.0,
                                                      ),
                                                      Obx(() => Container(
                                                          width: Get.width / 8,
                                                          child: controller
                                                                      .isSending
                                                                      .value ==
                                                                  false
                                                              ? ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      fixedSize:
                                                                          Size(
                                                                              100,
                                                                              20),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red),
                                                                  onPressed:
                                                                      () {
                                                                    controller.deletePost(
                                                                        mineposts[
                                                                            'id_post']);
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .delete_outlined,
                                                                      color: Colors
                                                                          .black87),
                                                                )
                                                              : Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
