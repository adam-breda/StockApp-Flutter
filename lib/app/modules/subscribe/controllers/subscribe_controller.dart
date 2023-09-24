import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SubscribeController extends GetxController {
  final box = GetStorage();
  var id_analyst = "".obs;
  var isLoading = false.obs;
  var isSending = false.obs;
  List<dynamic> portos = [].obs;
  List<dynamic> analysts = [].obs;
  List<dynamic> AnalystStockApp = [].obs;
  // List<dynamic> MyPlan = [].obs;
  final List<int> subs = [];
  var role = "".obs;

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    await AmbilAnalyst(); // Replace this with your actual data-fetching logic.
  }

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
        var result = jsonDecode(response.body)['data'];

        AnalystStockApp = result;
        print("ini analyst");
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
      // Get.snackbar('Error', 'Failed to get analystdcd',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  // PlanManage() async {
  //   try {
  //     print("Fetching all my plan");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/plan/manage';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       MyPlan = result;
  //       print("ini all my plan");
  //       print(MyPlan);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get analyst ',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get all my plan',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  // PlanManage() async {
  //   final token = box.read('token');

  //   try {
  //     isLoading.value = true;
  //     final dio = Dio();
  //     //print("fwfw");
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response = await dio.get('http://env-4734168.user.cloudjkt01.com/api/plan/manage');
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       print(data);
  //       MyPlan = data;

  //       // var d;
  //       // for (d in data) {
  //       //   subs.add(d['id_analyst']);
  //       // }
  //       isLoading.value = false;
  //       //fetchSubsPorto('');
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load my plan');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  // Future<void> fetchAnalyst() async {
  //   try {
  //     isLoading.value = true;
  //     final token = box.read('token');

  //     final dio = Dio();

  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response =
  //         await dio.get('http://env-4734168.user.cloudjkt01.com/api/portofolio/analyst');

  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       analysts = data;
  //       isLoading.value = false;
  //       print("analysts " + analysts.toString());
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load analysts');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  // Future<void> fetchSubsPorto(String typeName) async {
  //   var sType = '';
  //   if (typeName != 'semua') {
  //     sType = typeName;
  //   }
  //   try {
  //     isLoading.value = true;
  //     final token = box.read('token');

  //     final dio = Dio();
  //     Map<String, dynamic> data = {
  //       'type': '',
  //       'analyst_id': jsonEncode(subs),
  //     };
  //     final params = {
  //       'type': sType,
  //       'analyst_id': jsonEncode(subs),
  //     };
  //     print(params);
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response = await dio.post(
  //       'http://env-4734168.user.cloudjkt01.com/api/portofolio/subs',
  //       data: data,
  //     );
  //     // print(response.data['data']);
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       portos = data;
  //       isLoading.value = false;
  //       print("subs porto " + portos.toString());
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load portofolio');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // fetchAnalyst();
    // getSubscription();
    // fetchSubsPorto('');
    AmbilAnalyst();
    //PlanManage();
    role.value = box.read("role");
    // id_analyst.value = box.read("id_analyst");
    // print(id_analyst);
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
