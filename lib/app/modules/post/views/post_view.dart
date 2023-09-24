import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_app/app/models/NamaCompany.dart';
import 'package:stock_app/app/routes/app_pages.dart';

import '../../../Values/values.dart';
import '../../../models/Company.dart';
import '../controllers/post_controller.dart';

class PostView extends GetView<PostController> {
  PostView({Key? key}) : super(key: key);
  PostController controller = Get.put(PostController());
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  final TextEditingController valueBuatTag = new TextEditingController();
  List<NamaCompany> namaCompany = [];

  var isSending = false.obs;

  List<String> Tag = [
    "public",
    "private",
  ];

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
      'StockApp',
      'Posted New Post',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondary,
        appBar: AppBar(
          title: Text(
            "Add Post",
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  // Card(
                  //   color: secondary,
                  //   margin: EdgeInsets.all(10),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15)),
                  //   child:
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      padding: EdgeInsets.all(16),
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.84,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    //Text("Tag"),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: controller
                                                .selectedValueTag, // Nilai dropdown yang dipilih
                                            onChanged: (newValue) {
                                              controller.selectedValueTag =
                                                  newValue!; // Mengubah nilai dropdown yang dipilih
                                            },
                                            items: <String>[
                                              'private',
                                              'public',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                    value), // Teks yang akan ditampilkan pada dropdown
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Tag', // Label untuk dropdown
                                            ),
                                            // decoration: InputDecoration(
                                            //   labelText:
                                            //       'Pilih fundamental', // Label untuk dropdown
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text("Title"),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(fontSize: 13.0),
                                        hintText: 'title',
                                        hintStyle: TextStyle(fontSize: 11.0),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 12.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Content"),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: Get.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: _contentController,
                                    expands: false,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 13.0),
                                      hintText: 'content',
                                      hintStyle: TextStyle(fontSize: 11.0),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Obx(() => Container(
                                    width: Get.width,
                                    child: isSending.value == false
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(200, 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                backgroundColor:
                                                    Colors.redAccent[400]),
                                            onPressed: () async {
                                              controller.addPost(
                                                _titleController.text,
                                                _contentController.text,
                                                controller.valueTag.value
                                                    .toString(),
                                              );
                                              await initializeNotifications();
                                              await showNotification();
                                              controller.fetchMinePost();
                                            },
                                            child: Text("Simpan"))
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ))),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                  // )
                ],
              ),
            ),
          );
        }));
  }
}
