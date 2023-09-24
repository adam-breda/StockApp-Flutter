import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

class PaymentAdminController extends GetxController {
  final box = GetStorage();
  var emailUser = "".obs;
  var name = "".obs;
  var role = "".obs;
  List<dynamic> beliPortos = [].obs;
  List<dynamic> companies = [].obs;
  final idPortofolioBeliC = TextEditingController();
  final idPortofolioJualC = TextEditingController();
  final volumeC = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final tanggalBeliC = TextEditingController();
  final tanggalJualC = TextEditingController();
  final jenisSahamC = TextEditingController();

  var isLoading = false.obs;
  var isSending = false.obs;

  List<dynamic> report = [].obs;
  void logout() {
    box.remove("token");
    box.remove('email');
    box.remove('name');
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      //trend
      var apiUrl =
          'https://api.goapi.id/v1/stock/idx/trending?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        isLoading.value = true;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
        // print(c);
      } else {
        Get.snackbar('Error', 'Failed to get trending',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get trending',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchBeli() async {
    try {
      print("Fetching all portos");
      fetchCompanies();

      isLoading.value = false;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portofoliobeli';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        beliPortos = result;
      }
    } catch (error) {
      isLoading.value = false;
      // Get.snackbar('Error', 'Failed to get all portos',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Future<void> Report() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/report';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        report = result;
        print("ini report");
        print(report);
      } else {
        Get.snackbar('Error', 'Failed to get report profile',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get report profile',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Report();
    fetchCompanies();
    fetchBeli();
    print(box.read("email"));
    emailUser.value = box.read("email");
    name.value = box.read("name");
    role.value = box.read("role");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
