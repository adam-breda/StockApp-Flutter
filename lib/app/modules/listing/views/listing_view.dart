import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/CandleStick.dart';
// import '../../../widgets/StockChart30.dart';
import '../../../widgets/StockChartMini.dart';
import '../controllers/listing_controller.dart';

class ListingView extends GetView<ListingController> {
  ListingView({Key? key}) : super(key: key);
  ListingController controller = Get.put(ListingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    focusColor: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Search',
                ),
                onChanged: controller.updateSearchQuery,

                // onChanged: (value) {
                //   controller.updateSearchQuery(value);
                // },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent[400],
                  ));
                }
                return ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  physics: ClampingScrollPhysics(),
                  itemCount: controller.filteredCompanies.length,
                  itemBuilder: (context, index) {
                    final company = controller.filteredCompanies[index];

                    return Card(
                        color: secondary,
                        margin: EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          splashColor: Colors.redAccent.withAlpha(30),
                          onTap: () {
                            Get.toNamed(Routes.COMPANY_DETAIL, arguments: {
                              'ticker': company['ticker'],
                              'name': company['name'],
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(16),
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Get.width * .5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          company['ticker'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 25,
                                              color: Colors.redAccent[400]),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Container(
                                          child: Text(
                                            company['name'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.network(
                                    company['logo'],
                                    width: 40,
                                    height: 40,
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
    );
  }
}
