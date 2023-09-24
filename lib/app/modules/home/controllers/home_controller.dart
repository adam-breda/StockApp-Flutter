import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:stock_app/app/modules/home/views/home_view.dart';
import 'package:stock_app/app/modules/profile/views/profile_view.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // var companies = <Company>[].obs;
  var isLoading = false.obs;
  List<dynamic> companies = [].obs;
  final searchC = TextEditingController();

  void fetchCompanies() async {
    print("Fetching companies");
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/companies?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
        // print(c);
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
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
