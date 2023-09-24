import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../main.dart';
import '../../../Values/values.dart';
import '../../news_detail/controllers/news_detail_controller.dart';
import '../controllers/midtrans_controller.dart';
import '../controllers/payment_midtrans_controller.dart';

class MidtransView extends GetView<PaymentMidtransController> {
  MidtransView({Key? key}) : super(key: key);
  PaymentMidtransController controller = Get.put(PaymentMidtransController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent[400],
            ));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                      //height: 800,
                      child: WebViewWidget(
                          controller: controller.MidtransPayment)),
                ],
              ),
            ),
          );
        }));
  }
}
