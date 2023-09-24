import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PublicPostController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  List<dynamic> portos = [].obs;
  List<dynamic> analysts = [].obs;
  List<dynamic> publicpost = [].obs;
  List<dynamic> mine = [].obs;
  List<dynamic> refreshMine = [].obs;
  final List<int> subs = [];

  Map<String, dynamic> editPost = {};
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final tagC = TextEditingController();
  final List<String> tagOptions = ['public', 'private'];

  Future<void> updatePostMine(String id_post) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);

      final headers = {'Authorization': 'Bearer $token'};

      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/post/edit'),
        headers: headers,
        body: {
          'id_post': id_post,
          'title': titleC.text,
          'content': contentC.text,
          'tag': tagC.text,
        },
      );
      if (response.statusCode == 200) {
        isSending.value = false;
        //fetchJual();
        fetchMinePost();
        Get.back();
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Mine Post berhasil di update',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  Future<void> fetchPublicPost() async {
    try {
      print("Fetching all public post");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/post';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        publicpost = result;
        print('ini public post');
        print(publicpost);
      }
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<void> fetchMinePost() async {
    try {
      print("Fetching all mine post");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/post/managee';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        mine = result;
        print('ini mine post');
        print(mine);
      }
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<void> refreshMinePost() async {
    try {
      print("Fetching all mine post");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/post/managee';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        refreshMine = result;
        print('ini mine post');
        print(refreshMine);
      }
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<void> deletePost(int id_post) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          'http://env-4734168.user.cloudjkt01.com/api/post/delete/$id_post');
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        fetchMinePost();
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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // fetchAnalyst();
    print('ini public post');
    fetchPublicPost();
    print('ini mine post');
    fetchMinePost();
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
