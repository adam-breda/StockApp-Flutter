import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stock_app/app/routes/app_pages.dart';

import '../../../Values/values.dart';
import '../controllers/trend_controller.dart';

class TrendView extends GetView<TrendController> {
  TrendView({Key? key}) : super(key: key);
  TrendController controller = Get.put(TrendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent[400],
                  ));
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.companies.length,
                  itemBuilder: (context, index) {
                    final company = controller.companies[index];
                    final valueChange = company['change'];
                    //controller.selectType('Trend');

                    return Card(
                        color: secondary,
                        // margin: EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          splashColor: Colors.redAccent.withAlpha(30),
                          onTap: () {
                            Get.toNamed(Routes.COMPANY_DETAIL, arguments: {
                              'ticker': company['ticker'],
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
                                              color:
                                                  double.parse(valueChange) > 0
                                                      ? Colors.green
                                                      : Colors.red),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                "Close : " + company['close'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Container(
                                              child: Text(
                                                "Change : " + company['change'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: double.parse(
                                                                valueChange) >
                                                            0
                                                        ? Colors.green[400]
                                                        : Colors.red[400]),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      double.parse(valueChange) > 0
                                          ? Icon(Icons.arrow_drop_up,
                                              color: Colors.green[400],
                                              size: 35)
                                          : Icon(Icons.arrow_drop_down,
                                              color: Colors.red[400], size: 35),
                                      Text(
                                        double.parse(company['percent'])
                                                .toStringAsFixed(2) +
                                            " %",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )
                                    ],
                                  )
                                  // Image.network(
                                  //   company['logo'],
                                  //   width: 40,
                                  //   height: 40,
                                  // ),
                                ],
                              )),
                        ));
                  },
                );
              }),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '*Data tidak realtime (Berdasarkan close hari sebelumnya)',
                    style: TextStyle(
                        // fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Colors.black87),
                  ),
                  // Text(time?.toString() ?? "Empty"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
