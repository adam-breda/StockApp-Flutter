import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class PlanController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  //final Map arguments = Get.arguments;
  dynamic subsAnalyst = [].obs;
  //List<dynamic> detailAnalyst = [].obs;
  var detailAnalyst = {}.obs;
  dynamic hargaPilih = [].obs;
  Map<String, dynamic> detailpembayaran = {};
  List<dynamic> MyPlan = [].obs;

  final priceC = TextEditingController();
  final monthC = TextEditingController();
  final idPriceC = TextEditingController();

  Future<void> PlanManage() async {
    // final token = box.read('token');

    try {
      isLoading.value = true;
      // final dio = Dio();
      //print("fwfw");
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/plan/manage';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        MyPlan = result;
        print("isi my plan");
        print(MyPlan);
      }

      // dio.options.headers['Authorization'] = 'Bearer $token';
      // final response = await dio.get('http://env-4734168.user.cloudjkt01.com/api/plan/manage');
      // if (response.statusCode == 200) {
      //   final data = response.data['data'];
      //   print(data);
      //   MyPlan = data;

      //   // var d;
      //   // for (d in data) {
      //   //   subs.add(d['id_analyst']);
      //   // }
      //   isLoading.value = false;
      //   //fetchSubsPorto('');
      // } else {
      //   isLoading.value = false;
      //   throw Exception('Failed to load my plan');
      // }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  Future<void> updateMyPlan(String id_price) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      //  final dio = Dio();
      // dio.options.headers['Authorization'] = 'Bearer $token';
      final headers = {'Authorization': 'Bearer $token'};

      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/editPlanSendiri'),
        headers: headers,
        body: {
          'id_price': id_price,
          // 'price': int.parse(priceC.text).toString(),
          // 'month': int.parse(monthC.text).toString(),
          'price': priceC.text,
          'month': monthC.text,

          //'tag': tagC.text,
          //'name': nameC.text,
          // 'id_portofolio_beli': id_portofolio_beli,
          // 'volume': int.parse(volumeC.text).toString(),
          // 'harga_beli': int.parse(hargaBeliC.text).toString(),
          // 'tanggal_beli': tanggalBeliC.text,
        },
      );
      print(response);

      // final response = await dio.post(
      //   'http://env-4734168.user.cloudjkt01.com/api/plan/edit',
      //   data: {
      //     'id_price': id_price,
      //     'price': int.parse(priceC.text).toString(),
      //     'month': int.parse(monthC.text).toString(),
      //     //'fee': int.parse(feeC.text)
      //   },
      // );
      print(response.statusCode);
      if (response.statusCode == 200) {
        isSending.value = false;
        //fetchJual();
        //PlanManage();
        Get.back();
        PlanManage();
        // Get.back();
        Get.snackbar(
          'Berhasil',
          'Plan berhasil di update',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
        // Get.snackbar(
        //   priceC.text,
        //   monthC.text,
        //   margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        //   backgroundColor: Colors.green,
        // );
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  Future<void> deleteMyPlan(int id_price) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          'http://env-4734168.user.cloudjkt01.com/api/plan/delete/$id_price');
      if (response.statusCode == 200) {
        isSending.value = false;
        //Get.back();
        PlanManage();
        // fetchMinePost();
        //Get.back();
        Get.snackbar('Berhasil', 'Data berhasil di delete',
            backgroundColor: Colors.green);
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
      }
    } catch (e) {
      print(e);
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
    }
  }

  Future<void> addPlan(String price, String month) async {
    // int nTag = valueTag.value;
    // var nTagValue = ["Less Than", "More Than"][nTag];

    //var price = priceController.value;
    print("a");

    if (price == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi price',
          backgroundColor: Colors.red, colorText: Colors.white);
      print("b");
      return;
    }
    if (month == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi month',
          backgroundColor: Colors.red, colorText: Colors.white);
      print("c");
      return;
    }
    try {
      print("d");
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/addPlan'),
        headers: headers,
        body: {
          "aalystData": price,
          "price": price,
          "month": month,
          //'tag': selectedValueTag,
          // 'id_saham': selectedValueSaham,
        },
      );
      print(headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        // final result = json.decode(response.body);
        isSending.value = false;
        Get.back();
        Get.toNamed(Routes.PLAN);
        //Get.back();
        PlanManage();
        print("f");

        // Get.toNamed(Routes.PLAN);
        // fetchMinePost();
        print("ini response body");
        print("ini price " + price);
        print("ini month " + month);
        print("ini response + ${response.body}");
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
        // print('ini result');
        // print(result);

        Get.snackbar(
          'Berhasil',
          'Plan berhasil di tambah',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );

        print("h");
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal tambah plan');
        print("h");
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
    PlanManage();

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
