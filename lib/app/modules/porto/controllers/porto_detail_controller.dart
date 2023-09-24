import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PortoDetailController extends GetxController {
  //final Map arguments = Get.arguments;
  //final feeC = TextEditingController();
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  final Map arguments = Get.arguments;
  //Map<String, dynamic> DetailPorto = {};
  List<dynamic> DetailReport = [].obs;
  List<dynamic> KeuntunganDetailReport = [].obs;
  List<dynamic> RealisasiDetailReport = [].obs;

  Future<void> ReportData() async {
    try {
      print("Fetching all report history");
      isLoading.value = true;
      //final reportdetail = arguments['year'];
      final token = box.read('token');
      final year = arguments['year'];
      final emiten = arguments['nama_saham'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/portosemuaa/$year/$emiten';
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua$reportdetail';

      // final token = box.read('token');
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['data'];
        var keuntungan = jsonDecode(response.body)['data']['keuntungan'];
        var realisasi = jsonDecode(response.body)['data']['realisasi'];
        var a = jsonDecode(response.body)['data'];

        print("ini a");
        print(a);

        //var keuntungann = jsonEncode(keuntungan);

        DetailReport = result;
        print("ini report history");
        print(DetailReport);

        KeuntunganDetailReport = [keuntungan];
        print("ini keuntungan report history");
        print(KeuntunganDetailReport);

        RealisasiDetailReport = [realisasi];
        print("ini realisasi report history");
        print(RealisasiDetailReport);
      } else {
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to get report history',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print(Error);
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get report history',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print(error);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    ReportData();

    //saveTransactionBeli();
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
