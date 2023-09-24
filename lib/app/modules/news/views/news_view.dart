import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  NewsView({Key? key}) : super(key: key);
  NewsController controller = Get.put(NewsController());

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await controller
        .fetchNews(); // Replace this with your actual data-fetching logic.
    // await controller.fetchPortoSemua();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        backgroundColor: primary,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //     margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Stock Listing",
              //       style: TextStyle(
              //           fontWeight: FontWeight.w900,
              //           fontSize: 30,
              //           color: Colors.black54),
              //     )),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value == true) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.redAccent[400],
                    ));
                  }
                  return ListView.builder(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.news.length,
                    itemBuilder: (context, index) {
                      final newsfinal = controller.news[index];

                      return Card(
                          color: secondary,
                          margin: EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            splashColor: Colors.redAccent.withAlpha(30),
                            onTap: () {
                              Get.toNamed(Routes.NEWS_DETAIL, arguments: {
                                'title': newsfinal['title'],
                                'author': newsfinal['author'],
                                'description': newsfinal['description'],
                                'url': newsfinal['url'],
                                'urlToImage': newsfinal['urlToImage'],
                                'publishedAt': newsfinal['publishedAt'],
                                'content': newsfinal['content'],
                                'source': newsfinal['source']['name'],
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(12),
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //disini
                                    Image.network(
                                      newsfinal['urlToImage'],
                                      width: 150,
                                      height: 150,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                    Container(
                                      width: Get.width * .45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            newsfinal['title'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.redAccent[400]),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          // Container(
                                          //   child: Text(
                                          //     newsfinal['description'],
                                          //     style: TextStyle(
                                          //       fontSize: 14,
                                          //       fontWeight: FontWeight.bold,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ));
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
