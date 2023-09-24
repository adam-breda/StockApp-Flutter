import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:stock_app/app/modules/dashboard/controllers/detail_technical_controller.dart';
import 'package:stock_app/app/modules/dashboard/controllers/technical_controller.dart';
import 'package:stock_app/app/routes/app_pages.dart';
import 'package:stock_app/app/widgets/DetailTechnical.dart';

import '../../../Values/values.dart';
import '../../../widgets/StockChart30.dart';

class DetailTechnicalView extends GetView<DetailTechnicalController> {
  DetailTechnicalView({Key? key}) : super(key: key);
  DetailTechnicalController controller = Get.put(DetailTechnicalController());

  // String stockTrend = '';
  // String fundamental = '';
  // String lessThan = '';
  // String percent = '';
  // String startDate = '';
  // String endDate = '';

  // final TextEditingController stockTrendC = TextEditingController();
  // final TextEditingController fundamentalC = TextEditingController();
  // final TextEditingController lessThanC = TextEditingController();
  // final TextEditingController percentC = TextEditingController();
  // final TextEditingController startDateC = TextEditingController();
  // final TextEditingController endDateC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          "Detail " + controller.arguments['ticker'],
          //controller.arguments['dateEnd'].toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent[400],
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      width: Get.width * 2,
                      height: 400,
                      child: SingleChildScrollView(
                        child: DetailTechnical(),
                        //child: StockChart30(),

                        //child: CandleStickk(),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Card(
                        color: secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 0.3,
                        // width: Get.width * 2,
                        // height: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: Row(
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '__',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.redAccent),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.redAccent),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Low',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                              SizedBox(width: 10),
                              Column(children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '__',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.greenAccent),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.greenAccent),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'High',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                              SizedBox(width: 10),
                              Column(children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '__',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Open',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                              SizedBox(width: 10),
                              Column(children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '__',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.yellowAccent),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.yellowAccent),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Close',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          ),
                          //child: StockChart30(),

                          //child: CandleStickk(),
                          // scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ],
                );

                //final formatter = NumberFormat('#,###');

                // return ListView.builder(
                //   padding: EdgeInsets.zero,
                //   physics: AlwaysScrollableScrollPhysics(),
                //   itemCount: controller.MyPlan.length,
                //   itemBuilder: (context, index) {
                //     final PlanKu = controller.MyPlan[index];

                //     return Card(
                //       color: secondary,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child: InkWell(
                //         splashColor: Colors.redAccent.withAlpha(30),
                //         onTap: () {
                //           // Handle card tap here if needed
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(15.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     CurrencyFormat.convertToIdr(
                //                       PlanKu['price'],
                //                       0,
                //                     ),
                //                     style: TextStyle(
                //                       color: Colors.black87,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   ),
                //                   SizedBox(height: 5),
                //                   Text(
                //                     '${PlanKu['month']} Month',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.w500,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   Obx(() => Container(
                //                         width: Get.width / 8,
                //                         child: controller.isSending.value ==
                //                                 false
                //                             ? ElevatedButton(
                //                                 style: ElevatedButton.styleFrom(
                //                                   shape: RoundedRectangleBorder(
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             10),
                //                                   ),
                //                                   fixedSize: Size(100, 20),
                //                                   backgroundColor: Colors.green,
                //                                 ),
                //                                 onPressed: () {
                //                                   // Handle edit button press
                //                                   controller.priceC.text =
                //                                       PlanKu['price']
                //                                           .toString();
                //                                   controller.monthC.text =
                //                                       PlanKu['month']
                //                                           .toString();

                //                                   Get.defaultDialog(
                //                                     backgroundColor: primary,
                //                                     title: "EDIT PLAN",
                //                                     content: Container(
                //                                       alignment:
                //                                           Alignment.centerLeft,
                //                                       child: Column(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .start,
                //                                         crossAxisAlignment:
                //                                             CrossAxisAlignment
                //                                                 .start,
                //                                         children: [
                //                                           Text("Price"),
                //                                           SizedBox(height: 5),
                //                                           Container(
                //                                             width: Get.width,
                //                                             decoration:
                //                                                 BoxDecoration(
                //                                               color: Colors
                //                                                   .grey[300],
                //                                             ),
                //                                             child: TextField(
                //                                               controller:
                //                                                   controller
                //                                                       .priceC,
                //                                               keyboardType:
                //                                                   TextInputType
                //                                                       .number,
                //                                               decoration:
                //                                                   InputDecoration(
                //                                                 labelStyle:
                //                                                     TextStyle(
                //                                                         fontSize:
                //                                                             13.0),
                //                                                 hintText:
                //                                                     'Add Price',
                //                                                 hintStyle:
                //                                                     TextStyle(
                //                                                         fontSize:
                //                                                             11.0),
                //                                                 border:
                //                                                     InputBorder
                //                                                         .none,
                //                                                 contentPadding:
                //                                                     EdgeInsets.symmetric(
                //                                                         horizontal:
                //                                                             16.0,
                //                                                         vertical:
                //                                                             12.0),
                //                                               ),
                //                                             ),
                //                                           ),
                //                                           SizedBox(height: 10),
                //                                           Text("Month"),
                //                                           SizedBox(height: 5),
                //                                           Container(
                //                                             width: Get.width,
                //                                             decoration:
                //                                                 BoxDecoration(
                //                                               color: Colors
                //                                                   .grey[300],
                //                                             ),
                //                                             child: TextField(
                //                                               controller:
                //                                                   controller
                //                                                       .monthC,
                //                                               keyboardType:
                //                                                   TextInputType
                //                                                       .number,
                //                                               decoration:
                //                                                   InputDecoration(
                //                                                 labelStyle:
                //                                                     TextStyle(
                //                                                         fontSize:
                //                                                             13.0),
                //                                                 hintText:
                //                                                     'Add Month',
                //                                                 hintStyle:
                //                                                     TextStyle(
                //                                                         fontSize:
                //                                                             11.0),
                //                                                 border:
                //                                                     InputBorder
                //                                                         .none,
                //                                                 contentPadding:
                //                                                     EdgeInsets.symmetric(
                //                                                         horizontal:
                //                                                             16.0,
                //                                                         vertical:
                //                                                             12.0),
                //                                               ),
                //                                             ),
                //                                           ),
                //                                           SizedBox(height: 15),
                //                                           Row(
                //                                             mainAxisAlignment:
                //                                                 MainAxisAlignment
                //                                                     .center,
                //                                             children: [
                //                                               Obx(
                //                                                   () =>
                //                                                       Container(
                //                                                         width:
                //                                                             Get.width /
                //                                                                 3,
                //                                                         child: controller.isSending.value ==
                //                                                                 false
                //                                                             ? ElevatedButton(
                //                                                                 style: ElevatedButton.styleFrom(
                //                                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                //                                                                   fixedSize: Size(200, 40),
                //                                                                   backgroundColor: Colors.green,
                //                                                                 ),
                //                                                                 onPressed: () {
                //                                                                   // Handle update button press
                //                                                                   controller.updateMyPlan(PlanKu['id_price'].toString());
                //                                                                 },
                //                                                                 child: Text("Update"),
                //                                                               )
                //                                                             : Center(
                //                                                                 child: CircularProgressIndicator(),
                //                                                               ),
                //                                                       )),
                //                                             ],
                //                                           )
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   );
                //                                 },
                //                                 child: Icon(
                //                                   Icons.edit_outlined,
                //                                   color: Colors.black87,
                //                                 ),
                //                               )
                //                             : Center(
                //                                 child:
                //                                     CircularProgressIndicator(),
                //                               ),
                //                       )),

                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
