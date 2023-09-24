import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/routes/app_pages.dart';
import '../../../Values/values.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/tren_controller.dart';

class TrenView extends GetView<TrenController> {
  TrenView({Key? key}) : super(key: key);
  TrenController controller = Get.put(TrenController());

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
                final formatter = NumberFormat('#,##0.00');
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.Emitens.length,
                  itemBuilder: (context, index) {
                    final company = controller.Emitens[index];
                    final valueChange = company['change'];

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
                                    width: Get.width * .8,
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
                                                      ? Colors.green[400]
                                                      : Colors.red[400]),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Trend : " + company['trend'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(),
                                            Container(
                                              child: Text(
                                                // formatter.format(int.parse(

                                                //         company['change'])),
                                                // CurrencyFormat.convertToIdr(
                                                //     double.parse(
                                                //         company['change']),
                                                //     0),
                                                // formatter.format(double.parse(
                                                //     company['change'])),
                                                // // (string.Format("{0:n2}", inputedNumber)
                                                // "Change : " +
                                                //     company['change'] +
                                                //     "%".toString(),
                                                "Change : " +
                                                    formatter.format(
                                                        double.parse(company[
                                                            'change'])) +
                                                    "%",
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
