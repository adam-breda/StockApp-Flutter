import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../main.dart';

class NewsController extends GetxController {
  var isLoading = false.obs;
  List<dynamic> news = [].obs;
  List<dynamic> berita = [].obs;

  Future<void> fetchNews() async {
    print("Fetching news");
    try {
      isLoading.value = true;
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 30));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=saham&sortBy=relevancy&apiKey=c164420dbd014ac6ac1f8645a9330438&language=id'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var resultnews = jsonDecode(response.body)['articles'];
        news = resultnews;
        // print(c);
      } else {
        Get.snackbar('Error', 'Failed to get news',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get news',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchBerita() async {
    try {
      print("Fetching all berita");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/berita';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        berita = result;
      } else {
        Get.snackbar('Error', 'Failed to get news',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get news',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
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
