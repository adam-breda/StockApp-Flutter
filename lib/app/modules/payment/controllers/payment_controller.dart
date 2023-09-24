import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_app/app/api/api_service.dart';

import '../../../routes/app_pages.dart';

class PaymentController extends GetxController {
  final Map arguments = Get.arguments;
  var metodePembayaran = ''.obs;
  final ApiService apiService = ApiService();

  void payTagihan(int id, String metode) async {
    try {
      final payStatus = await apiService.payTagihan(id, metode);
      print(payStatus);
      if (payStatus == 'Berhasil') {
        Get.snackbar('Success', 'Payment success',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pay tagihan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
