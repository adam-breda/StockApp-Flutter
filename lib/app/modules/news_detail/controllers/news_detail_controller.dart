import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';

class NewsDetailController extends GetxController {
  final Map arguments = Get.arguments;
  final volumeC = TextEditingController();
  final feeC = TextEditingController();
  final commentC = TextEditingController();
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  var role = "".obs;
  Map<String, dynamic> news = {};

  void fetchDetailNews() async {
    print("Fetching news");

    try {
      isLoading.value = true;
      final berita = arguments['title'];
      print("judul isi berita: " + berita);
      print("coba aja mau aoa engga");
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$berita&apiKey=c164420dbd014ac6ac1f8645a9330438'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final resultnews = parsedJson['articles'];

        news = resultnews;
        print("news ini: " + resultnews);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  @override
  void onInit() {
    super.onInit();
    role.value = box.read("role");
    fetchDetailNews();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    volumeC.dispose();
    super.onClose();
  }
}
