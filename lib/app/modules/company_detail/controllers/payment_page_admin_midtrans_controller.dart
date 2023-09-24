import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/models/JenisSaham.dart';
import 'package:stock_app/app/widgets/JenisSahamDropDown.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../main.dart';
import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/HistorycalData.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart120.dart';
import '../../../widgets/StockChart30.dart';
import '../../../widgets/StockChart60.dart';
import '../../../widgets/StockChart90.dart';

class PaymentPageAdminMidtransController extends GetxController {
  //final Map arguments = Get.arguments;
  // final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;

  var role = "".obs;
  var status = "".obs;

  //dynamic subsAdmin = [].obs;
  List<dynamic> subsAdmin = [].obs;

  Map<String, dynamic> HasilAnalystFinancial = {};

  Future<void> fetchSubAnalystAdmin() async {
    try {
      print("Fetching all subs ADMIN");
      isLoading.value = true;
      final token = box.read('token');
      final id = "7";
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/plan/7';
      print(apiUrl);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      //  print("Entah ${JsonEncoder.withIndent('    ').convert(response.body)}");

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['prices'];

        subsAdmin = result;
        print('ini subs admin');
        print(subsAdmin);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get subs analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // role.value = box.read("role");

    fetchSubAnalystAdmin();

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }
  }
}
