import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TrenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();
  final searchC = TextEditingController();
  var isLoading = false.obs;
  //List<dynamic> abc = [].obs;
  List<dynamic> TrendPortos = [].obs;
  var name = "".obs;
  var role = "".obs;
  var initPage = "Top Loser".obs;
  List<dynamic> Emitens = [].obs;

  // Future<void> fetchTrends() async {
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

  //       TrendPortos = result;
  //     } else {
  //       Get.snackbar('Error', 'Failed to get trend',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get trend',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  Future<void> fetchEmitenn() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://www.env-4734168.user.cloudjkt01.com/api/trend';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        Emitens = result;
        print("ini trend");
        print(Emitens);
      }
    } catch (error) {
      isLoading.value = false;
      // Get.snackbar('Error', 'Failed to get porto jual',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Future<void> fetchEmiten() async {
    try {
      print("Fetching all emiten");
      print("Fetching all emiten");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/trending';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        Emitens = result;
        print("ini Emitens");
        print(Emitens);
      } else {
        Get.snackbar('Error', 'Failed to get trend',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get trend',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    //fetchTrends();
    print("test");
    Text("ini emiten");
    fetchEmiten();
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
}
