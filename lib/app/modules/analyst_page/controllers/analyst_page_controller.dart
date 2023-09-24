import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class AnalystPageController extends GetxController {
  final box = GetStorage();
  final selectedType = "semua".obs;
  final selectedAnalyst = 0.obs;
  final Map arguments = Get.arguments;
  var isLoading = false.obs;
  var alreadySubscribe = 'false'.obs;
  List<dynamic> portos = [].obs;
  void selectType(String type) {
    selectedType.value = type;
    fetchPorto(type);
  }

  Future<void> fetchPorto(String typeName) async {
    var sType = '';
    if (typeName != 'semua') {
      sType = typeName;
    }
    try {
      isLoading.value = true;
      final token = box.read('token');

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://http://env-4734168.user.cloudjkt01.com//api/portofolio/analystporto',
        data: {'type': sType, 'id_analyst': arguments['analyst']['id']},
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        portos = data;
        isLoading.value = false;
        print(portos);
      } else {
        isLoading.value = false;
        throw Exception('Failed to load portofolio');
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  Future<void> checkSubscription() async {
    final id = arguments['analyst']['id'];

    final token = box.read('token');
    try {
      isLoading.value = true;
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
          'http://http://env-4734168.user.cloudjkt01.com//api/portofolio/checksubcription',
          data: {'id_analyst': id});
      print(response.data);
      if (response.statusCode == 200) {
        final status = response.data['status'];
        print("status : " + status.toString());
        if (status == 'true') {
          alreadySubscribe.value = 'true';
        }
      } else {
        isLoading.value = false;
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> subscribe() async {
    final token = box.read('token');
    try {
      isLoading.value = true;
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
          'http://http://env-4734168.user.cloudjkt01.com//api/portofolio/subscribe',
          data: {'id_analyst': arguments['analyst']['id']});

      if (response.statusCode == 200) {
        final status = response.data['status'];
        Get.toNamed(Routes.TAGIHAN);
      } else {
        isLoading.value = false;
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> unsubscribe() async {
    final token = box.read('token');
    print("id analyst " + arguments['analyst']['id'].toString());
    try {
      isLoading.value = true;
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
          'http://http://env-4734168.user.cloudjkt01.com//api/portofolio/unsubscribe',
          data: {'id_analyst': arguments['analyst']['id']});

      if (response.statusCode == 200) {
        final status = response.data['status'];
        Get.snackbar('Success', 'Unsubscribe success',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.toNamed(Routes.HOME);
      } else {
        isLoading.value = false;
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();

    checkSubscription();
    fetchPorto('');
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
