import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../routes/app_pages.dart';
import '../controllers/subscribe_controller.dart';

class SubscribeView extends GetView<SubscribeController> {
  SubscribeView({Key? key}) : super(key: key);
  SubscribeController controller = Get.put(SubscribeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: primary,
        // body: Padding(
        //   padding: EdgeInsets.all(15),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       // SizedBox(
        //       //   height: 60,
        //       // ),
        //       // Container(
        //       //   child: Text(
        //       //     'Analyst',
        //       //     style: TextStyle(
        //       //         color: Colors.redAccent[400],
        //       //         fontSize: 30,
        //       //         fontWeight: FontWeight.bold),
        //       //   ),
        //       // ),
        //       Expanded(child: Obx(() {
        //         if (controller.isLoading.value == true) {
        //           return Center(
        //               child: CircularProgressIndicator(
        //             color: Colors.redAccent[400],
        //           ));
        //         }
        //         final formatter = NumberFormat('#,###');
        //         return ListView.builder(
        //             // scrollDirection: Axis.horizontal,
        //             physics: AlwaysScrollableScrollPhysics(),
        //             itemCount: controller.analysts.length,
        //             itemBuilder: (context, index) {
        //               final analyst = controller.analysts[index];

        //               return Container(
        //                   width: Get.width * .5,
        //                   margin: EdgeInsets.only(bottom: 10),
        //                   padding: EdgeInsets.all(10),
        //                   decoration: BoxDecoration(
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.5),
        //                           spreadRadius: 2,
        //                           blurRadius: 5,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ],
        //                       color: secondary,
        //                       borderRadius: BorderRadius.circular(7)),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 analyst['name'],
        //                                 maxLines: 1,
        //                                 style: TextStyle(
        //                                     color: Colors.redAccent[400],
        //                                     fontSize: 20,
        //                                     fontWeight: FontWeight.bold),
        //                               ),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(analyst['email']),
        //                             ],
        //                           ),
        //                           Row(
        //                             children: [
        //                               Icon(
        //                                 Icons.monetization_on,
        //                                 size: 16,
        //                                 color: Colors.redAccent[400],
        //                               ),
        //                               SizedBox(
        //                                 width: 5,
        //                               ),
        //                               Text(
        //                                   style: TextStyle(
        //                                       color: Colors.redAccent[400],
        //                                       fontWeight: FontWeight.bold,
        //                                       fontSize: 15),
        //                                   // formatter.format(double.parse(
        //                                   analyst['subscribe_fee'].toString()
        //                                   //  )
        //                                   // ),
        //                                   )
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height: 20,
        //                       ),
        //                       ElevatedButton(
        //                           onPressed: () {
        //                             Get.toNamed(Routes.ANALYST_PAGE,
        //                                 arguments: {'analyst': analyst});
        //                           },
        //                           style: ElevatedButton.styleFrom(
        //                             backgroundColor: Colors.redAccent[400],
        //                             minimumSize: Size(80, 36),
        //                             padding:
        //                                 EdgeInsets.symmetric(horizontal: 5),
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(5.0),
        //                             ),
        //                           ),
        //                           child: Row(
        //                             children: [
        //                               Icon(Icons.visibility),
        //                               SizedBox(
        //                                 width: 10,
        //                               ),
        //                               Text(
        //                                 "View",
        //                                 style: TextStyle(fontSize: 14),
        //                               ),
        //                             ],
        //                           ))
        //                     ],
        //                   ));
        //             });
        //       }))
        //     ],
        //   ),
        // )
        );
  }
}
