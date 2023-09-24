import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

class ProfileReportController extends GetxController {
  final Map arguments = Get.arguments;
  final box = GetStorage();
  // var emailUser = "".obs;
  // var name = "".obs;
  // var role = "".obs;

  var isLoading = false.obs;

  List<dynamic> reportHistory = [].obs;
  List<dynamic> Subscriber = [].obs;

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
        var result = jsonDecode(response.body)['data'];
        // DateTime tanggal =
        //     jsonDecode(response.body)['data']['existing']['expired'];

        // Duration difference = tanggal.difference(waktuIni);
        // var daysDifference = difference.inDays;
        //int differenceInDays = calculateDifferenceInDays(waktuIni, tanggal);
        // TanggalSelisih = [daysDifference];
        Subscriber = result;
        print("ini subscriber");
        print(Subscriber);
        // print("ini selisih hari");
        // print(daysDifference);
      } else {
        Get.snackbar('Error', 'Failed to get subcriber ',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get susbcriber',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // void logout() {
  //   box.remove("token");
  //   box.remove('email');
  //   box.remove('name');
  //   Get.offAllNamed(Routes.LOGIN);
  // }

  // Future<void> Report() async {
  //   try {
  //     print("Fetching all portos");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/report';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       report = result;
  //       print("ini report");
  //       print(report);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get portos',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get portos',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  Future<void> ReportHistory() async {
    try {
      print("Fetching all report history");
      isLoading.value = true;
      //final reportdetail = arguments['year'];
      final token = box.read('token');
      final year = arguments['year'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/reporthistory/$year';
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
        var result = jsonDecode(response.body)['data'];

        reportHistory = result;
        print("ini report history");
        print(reportHistory);
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

  // Future<void> ReportDetail() async {
  //   try {
  //     print("Fetching report detail");
  //     isLoading.value = true;
  //     final reportdetail = arguments['year'];
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/report/yearr$reportdetail';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       reporttahun = result;
  //       print("ini reporttahun");
  //       print(reporttahun);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get report tahun profile',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get report tahun profile',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // print("blablabla");
    // ReportDetail();
    ReportHistory();
    // print(box.read("email"));
    // emailUser.value = box.read("email");
    // name.value = box.read("name");
    // role.value = box.read("role");
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
