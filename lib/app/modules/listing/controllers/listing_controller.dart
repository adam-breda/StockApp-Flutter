import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:stock_app/app/models/NamaCompany.dart';

import '../../../models/HistorycalData.dart';

class ListingController extends GetxController {
  var isLoading = false.obs;
  // List<Map<String, dynamic>> companies = [];
  List<dynamic> searchcompanies = [].obs;
  List<dynamic> companies = [].obs;
  RxString searchQuery = ''.obs;
  List<dynamic> searchNamaSaham = [];
  //List<NamaCompany> companies = [];
  //final Map arguments = Get.arguments;
  final historicalData = <HistoricalData>[].obs;

  var namasaham = <String>[];

  void fetchHistoricalData() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 30));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/companies/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        historicalData.assignAll(historicalDataList);
        print("historical data : " + historicalData.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  Future<void> fetchCompanies() async {
    print("Fetching companies");
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/companies?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
        searchcompanies = result;
        // print(c);
      } else {
        Get.snackbar('Error', 'Failed to get companies',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get companies',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Step 2: Add a method to update the search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Step 3: Add a computed observable to filter companies based on search query
  List<dynamic> get filteredCompanies {
    final query = searchQuery.value.toLowerCase();
    return searchcompanies.where((company) {
      return company['ticker'].toLowerCase().contains(query) ||
          company['name'].toLowerCase().contains(query);
    }).toList();
  }

  // updateData() {
  //   if (searchNamaSaham.isEmpty) {
  //     fetchCompanies();
  //   } else {
  //     searchNamaSaham.addAll(companies
  //         .where((element) =>
  //             element.ticker.toLowerCase().startswith(searchNamaSaham))
  //         .toList());
  //   }
  // }

  // search(String ticker) {
  //   searchNamaSaham = ticker;
  //   updateData();
  // }

  List<dynamic> results = [];

  void filterSearchResultss(String search) {
    {
      // String value = editingController.text;

      if (search.isEmpty) {
        results = companies;
      } else {
        results = companies
            .where((element) =>
                element.ticker.toLowerCase().startswith(searchNamaSaham))
            .toList();
        print(results);
      }

      // searchcompanies = companies
      //     .where((item) => item.contains(query.toLowerCase()))
      //     .toList();
    }
    ;
  }

  // void SearchBar(String text) {
  //   companies = companies.where((item) {

  //   })
  // }

  // void filterSearchResults(String query) {
  //   List<dynamic> results = [];
  //   if (query.isEmpty) {
  //     results = companies;
  //   }else{
  //     results = companies.where((ticker) => item.contains(query.toLowerCase))
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();

    // filterSearchResults('');
    // searchcompanies = companies;
    // results = companies;
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
