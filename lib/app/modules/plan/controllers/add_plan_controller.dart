import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class AddPlanController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  // final Map arguments = Get.arguments;
  // dynamic subsAnalyst = [].obs;
  // //List<dynamic> detailAnalyst = [].obs;
  // var detailAnalyst = {}.obs;
  // dynamic hargaPilih = [].obs;
  // Map<String, dynamic> detailpembayaran = {};
  // List<dynamic> MyPlan = [].obs;

  // final priceC = TextEditingController();
  // final monthC = TextEditingController();
  // final idPriceC = TextEditingController();

  Future<void> addPlan(String price, String month) async {
    // int nTag = valueTag.value;
    // var nTagValue = ["Less Than", "More Than"][nTag];

    if (price == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi judul',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (month == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi month',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/plan/insert'),
        headers: headers,
        body: {
          'price': price,
          'month': month,
          //'tag': selectedValueTag,
          // 'id_saham': selectedValueSaham,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        isSending.value = false;
        Get.back();
        //Get.back();

        // Get.toNamed(Routes.PLAN);
        // fetchMinePost();
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
        Get.snackbar(
          'Berhasil',
          'Plan berhasil di tambah',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal tambah plan');
      }
    } catch (e) {
      isSending.value = false;
      print("ini error");
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();

    print("ini my plan");
    // PlanManage();

    // fetchDetailAnalyst();
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
