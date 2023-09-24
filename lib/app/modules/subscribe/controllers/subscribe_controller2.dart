import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SubscribeController2 extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  List<dynamic> portos = [].obs;
  List<dynamic> AnalystStockApp = [].obs;
  List<dynamic> RefreshAnalystStockApp = [].obs;
  List<dynamic> AnalystStockApp1 = [].obs;
  List<dynamic> AnalystStockAppExisting = [].obs;
  List<dynamic> requestUser = [].obs;
  final List<int> subs = [];
  //final Map arguments = Get.arguments;
  dynamic subscribed = [].obs;
  DateTime waktuIni = DateTime.now();

  int SelisihHari = 0;
  List<dynamic> TanggalSelisih = [].obs;

  // Future<void> CheckRequest() async {
  //   try {
  //     print("Fetching request");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/requestuser';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data']['pending'];
  //       // DateTime tanggal =
  //       //     jsonDecode(response.body)['data']['existing']['expired'];

  //       // Duration difference = tanggal.difference(waktuIni);
  //       // var daysDifference = difference.inDays;
  //       //int differenceInDays = calculateDifferenceInDays(waktuIni, tanggal);
  //       // TanggalSelisih = [daysDifference];
  //       requestUser = result;
  //       print("ini request");
  //       print(requestUser);
  //       // print("ini selisih hari");
  //       // print(daysDifference);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get request ',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get request',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //     print(error);
  //   }
  // }

  Future<void> AmbilAnalyst() async {
    try {
      print("Fetching all analyst");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/analyst';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['toFollow'];

        AnalystStockApp = result;
        print("ini analyst to follow");
        print(AnalystStockApp);
      } else {
        Get.snackbar('Error', 'Failed to get analyst ',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> AmbilAnalystRefresh() async {
    try {
      print("Fetching all analyst");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/analyst';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['toFollow'];

        RefreshAnalystStockApp = result;
        print("ini analyst to follow");
        print(RefreshAnalystStockApp);
      } else {
        Get.snackbar('Error', 'Failed to get analyst ',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> AmbilAnalystExisting() async {
    try {
      print("Fetching all analyst");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/analyst';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['existing'];
        // DateTime tanggal =
        //     jsonDecode(response.body)['data']['existing']['expired'];

        // Duration difference = tanggal.difference(waktuIni);
        // var daysDifference = difference.inDays;
        //int differenceInDays = calculateDifferenceInDays(waktuIni, tanggal);
        // TanggalSelisih = [daysDifference];
        AnalystStockAppExisting = result;
        print("ini analyst existing");
        print(AnalystStockAppExisting);
        // print("ini selisih hari");
        // print(daysDifference);
      } else {
        Get.snackbar('Error', 'Failed to get analyst ',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get analyst',
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
    // getSubscription();
    print("ini ambil analyst");
    AmbilAnalyst();
    //AmbilAnalyst1();
    AmbilAnalystExisting();
    //CheckRequest();
    // fetchSubsPorto('');
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
