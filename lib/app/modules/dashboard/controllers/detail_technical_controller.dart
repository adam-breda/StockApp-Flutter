import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../models/HistorycalData.dart';

class DetailTechnicalController extends GetxController {
  final box = GetStorage();
  final searchC = TextEditingController();
  var isLoading = false.obs;
  List<dynamic> companies = [].obs;
  var name = "".obs;
  var role = "".obs;
  var initPage = "Top Gainer".obs;
  final DetailTechnical = <HistoricalData>[].obs;
  final Map arguments = Get.arguments;
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();

  void fetchDetailTechnical() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 30));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${arguments['dateStart']}&to=${arguments['dateEnd']}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        DetailTechnical.assignAll(historicalDataList.reversed);
        print("historical data : " + DetailTechnical.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
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
