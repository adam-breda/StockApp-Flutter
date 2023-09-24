import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TrendController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();
  final searchC = TextEditingController();
  var isLoading = false.obs;
  List<dynamic> companies = [].obs;
  var name = "".obs;
  var role = "".obs;
  var initPage = "trend".obs;
  //List<dynamic> requestUser = [].obs;
  // var requestUser = {}.obs;
  // Map<String, dynamic> userrr = {};

  void selectType(String type) {
    initPage.value = type;
    fetchCompanies(type);
  }

  Future<void> fetchCompanies(type) async {
    try {
      isLoading.value = true;
      //trend
      var apiUrl =
          'https://api.goapi.id/v1/stock/idx/trending?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        isLoading.value = false;
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

  Future<void> fetchTopGainer() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/top_gainer?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
        // print(c);
      } else {
        Get.snackbar('Error', 'Failed to get top gainer',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get top gainer',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

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
  //       var result = jsonDecode(response.body)['data'];
  //       var req = jsonDecode(response.body)['data']['pending']['status'];
  //       // final hasil = result;
  //       // String valueChange = hasil['status'];
  //       // DateTime tanggal =
  //       //     jsonDecode(response.body)['data']['existing']['expired'];

  //       // Duration difference = tanggal.difference(waktuIni);
  //       // var daysDifference = difference.inDays;
  //       //int differenceInDays = calculateDifferenceInDays(waktuIni, tanggal);
  //       // TanggalSelisih = [daysDifference];
  //       requestUser = result;
  //       // userrr = req;
  //       print("ini request");
  //       print(requestUser);

  //       print("ini status");
  //       print(req[0]['status']);
  //       // print(valueChange);
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

  @override
  void onInit() {
    super.onInit();
    fetchCompanies('Trend');
    //CheckRequest();
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
