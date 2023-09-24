import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DetailAnalystController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  final Map arguments = Get.arguments;
  dynamic subsAnalyst = [].obs;
  //List<dynamic> detailAnalyst = [].obs;
  var detailAnalyst = {}.obs;
  var PortoBeliAnalyst = {}.obs;
  var PortoJualAnalyst = {}.obs;
  dynamic hargaPilih = [].obs;
  Map<String, dynamic> detailpembayaran = {};

  Future<void> fetchDetailAnalyst() async {
    try {
      print("Fetching detail analyst");
      isLoading.value = true;
      final token = box.read('token');
      final id = arguments['id'];
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/profile/$id';
      print("ini apirul");
      print(apiUrl);

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print("ini response");
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("print huruf b");

        var result = jsonDecode(response.body)['data'];

        detailAnalyst.value = result;
        // detailAnalyst.update((val) {
        //   detailAnalyst.value = result;
        // });
        isLoading.value = false;
        print('ini detail analyst');
        print(result);
      } else {
        // print(Error());
        Get.snackbar('Error', 'Failed to get detail analyst1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print("c");
      print(error);
      Get.snackbar('Error', 'Failed to get detail analyst2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchDetailAnalystPortobeli() async {
    try {
      print("Fetching detail porto beli analyst");
      isLoading.value = true;
      final token = box.read('token');
      final id = arguments['id'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/profile/portobeli/$id';
      print("ini apirul");
      print(apiUrl);

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print("ini response");
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("print huruf buwuwu");

        var result = jsonDecode(response.body)['data'];

        PortoBeliAnalyst.value = result;
        // PortoBeliAnalyst.update((val) {
        //   PortoBeliAnalyst.value = result;
        // });
        isLoading.value = false;
        print('ini detail analyst beli');
        print(PortoBeliAnalyst);
      } else {
        // print(Error());
        Get.snackbar('Error', 'Failed to get detail analyst1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print("c");
      print(error);
      Get.snackbar('Error', 'Failed to get detail analyst2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchDetailAnalystPortojual() async {
    try {
      print("Fetching detail porto beli analyst");
      isLoading.value = true;
      final token = box.read('token');
      final id = arguments['id'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/profile/portojual/$id';
      print("ini apirul");
      print(apiUrl);

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print("ini response");
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("print huruf bfefe");

        var result = jsonDecode(response.body)['data'];

        PortoJualAnalyst.value = result;
        // PortoJualAnalyst.update((val) {
        //   PortoBeliAnalyst.value = result;
        // });
        isLoading.value = false;
        print('ini detail analyst jual');
        print(PortoJualAnalyst);
      } else {
        // print(Error());
        Get.snackbar('Error', 'Failed to get detail analyst1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print("c");
      print(error);
      Get.snackbar('Error', 'Failed to get detail analyst2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();

    print("ini detail analyst");

    fetchDetailAnalyst();
    fetchDetailAnalystPortobeli();
    fetchDetailAnalystPortojual();
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
