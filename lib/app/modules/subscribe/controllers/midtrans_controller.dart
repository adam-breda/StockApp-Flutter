import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MidtransController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  final Map arguments = Get.arguments;
  dynamic subsAnalyst = [].obs;
  List<dynamic> detailAnalyst = [].obs;
  //dynamic detailAnalyst = [].obs;
  dynamic hargaPilih = [].obs;
  Map<String, dynamic> detailpembayaran = {};

  Future<void> fetchSubAnalyst() async {
    try {
      print("Fetching all subs analyst");
      isLoading.value = true;
      final token = box.read('token');
      final id = arguments['id'];
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/plan/$id';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      //  print("Entah ${JsonEncoder.withIndent('    ').convert(response.body)}");

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        subsAnalyst = result;
        print('ini subs analyst');
        print(subsAnalyst);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get subs analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Future<void> fetchDetailAnalyst() async {
  //   try {
  //     print("Fetching detail analyst");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     final id = arguments['id'];
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/profile/$id';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     //  print("Entah ${JsonEncoder.withIndent('    ').convert(response.body)}");

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       detailAnalyst = result;
  //       print('ini detail analyst');
  //       print(detailAnalyst);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get detail analyst',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  void DetailSubs() async {
    print("Fetching detail subs");

    try {
      isLoading.value = true;
      final bulan = arguments['month'];
      print("judul isi berita: " + bulan);
      print("coba aja mau aoa engga");
      final response = await http.get(Uri.parse(
          'http://env-4734168.user.cloudjkt01.com/api/detailsubscribe/$bulan'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final resultnews = parsedJson['data'];

        detailpembayaran = resultnews;
        print("news ini: " + resultnews);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  Future<void> fetchSubAnalystDetail() async {
    try {
      print("Fetching detail subs analyst");
      isLoading.value = true;
      final token = box.read('token');
      final id = arguments['id'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/detailsubscribe/$id';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        hargaPilih = result;
        print('ini harga pilih');
        print(hargaPilih);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get subs analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
  // List<dynamic> portos = [].obs;
  // List<dynamic> AnalystStockApp = [].obs;
  // final List<int> subs = [];

  // Future<void> getSubscription() async {
  //   final token = box.read('token');

  //   try {
  //     isLoading.value = true;
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response =
  //         await dio.get('http://env-4734168.user.cloudjkt01.com/api/portofolio/subuser');
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       print(data);
  //       var d;
  //       for (d in data) {
  //         subs.add(d['id_analyst']);
  //       }
  //       isLoading.value = false;
  //       fetchSubsPorto('');
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load portofolio');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  // Future<void> AmbilAnalyst() async {
  //   try {
  //     print("Fetching all analyst");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/analyst';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       AnalystStockApp = result;
  //       print("ini analyst");
  //       print(AnalystStockApp);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get analyst ',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get analystdcd',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  // Future<void> AmbilAnalyst() async {
  //   try {
  //     print("Fetching all analyst");
  //     //fetchCompanies();

  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/analyst';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['toFollow'];

  //       AnalystStockApp = result;
  //       print(AnalystStockApp);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     // Get.snackbar('Error', 'Failed to get all portos',
  //     //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     backgroundColor: Colors.red,
  //     //     colorText: Colors.white);
  //   }
  // }

  // Future<void> AmbilAnalyst() async {
  //   try {
  //     isLoading.value = true;
  //     final token = box.read('token');

  //     final dio = Dio();

  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response = await dio.get('http://env-4734168.user.cloudjkt01.com/api/analyst');

  //     if (response.statusCode == 200) {
  //       // final data = response.data['data'];
  //       final data = response.data['toFollow'];
  //       print(data);
  //       AnalystStockApp = data;
  //       print(AnalystStockApp);
  //       // analysts = data;
  //       isLoading.value = false;
  //       // print("analysts " + analysts.toString());
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
    // getSubscription();
    print("ini subs analyst");
    fetchSubAnalyst();
    // fetchDetailAnalyst();
    //AmbilAnalyst();
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
