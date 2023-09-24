import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../Values/values.dart';
import '../models/HistorycalData.dart';
import 'package:fl_chart/fl_chart.dart';

import '../modules/company_detail/controllers/company_detail_controller.dart';

class tabel extends StatelessWidget {
  CompanyDetailController controller = Get.put(CompanyDetailController());
  final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    // return AspectRatio(
    //   aspectRatio: 2,
    return AspectRatio(
      aspectRatio: 2,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: controller.tabel.length,
        itemBuilder: (context, index) {
          final detailTabel = controller.tabel[index];

          return Card(
              color: red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                  splashColor: Colors.redAccent.withAlpha(30),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DER'),
                                // Text(
                                //   detailTabel['outputData']['laba_bersih']
                                //       .toString(),
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )));
        },
      ),
    );
    // );
  }
}
