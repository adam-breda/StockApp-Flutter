import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/models/JenisSaham.dart';
import 'package:stock_app/app/widgets/JenisSahamDropDown.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../main.dart';
import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/HistorycalData.dart';
import '../../../models/TabelValuation.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart120.dart';
import '../../../widgets/StockChart30.dart';
import '../../../widgets/StockChart60.dart';
import '../../../widgets/StockChart90.dart';

class CompanyDetailTabelController extends GetxController {
  final Map arguments = Get.arguments;

  var isLoading = false.obs;
  var isSending = false.obs;
  final DetailValuation = <TabelValuation>[].obs;
  final Tahun = <TabelValuation>[].obs;

  //Map<String, dynamic> semuatechnical = {};
  //List<Map<String, dynamic>> semuatechnical = [];
  // List<Map<String, dynamic>> semuatechnical = <Map<String, dynamic>>[].obs;
  //var semuatechnical;
  //\\Map<String, dynamic> semuatechnical = {};
  List<dynamic> semuatechnical = [].obs;
  List<dynamic> hasil = [].obs;
  List<dynamic> valuationpbv = [].obs;
  final Tabell = <TabelValuation>[].obs;
  //Map<String, dynamic> hasil = {};
  var Semua = {}.obs;

  // void fetchDetailValuation() async {
  //   print("Fetching historical data");
  //   try {
  //     DateTime today = DateTime.now();
  //     DateTime dStart = today.subtract(Duration(days: 30));
  //     DateTime dEnd = today;

  //     final response = await http.get(Uri.parse(
  //         'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

  //     if (response.statusCode == 200) {
  //       final jsonString = response.body;
  //       final parsedJson = jsonDecode(jsonString);
  //       // final results = parsedJson['data']['results'];
  //       // List<TabelValuation> TabelValuationList = List<TabelValuation>.from(
  //       //   results.map((json) => TabelValuation.fromJson(json)),
  //       // );

  //       // DetailValuation.assignAll(TabelValuationList.reversed);
  //       // print("historical data : " + DetailValuation.toString());
  //     } else {
  //       throw Exception('Failed to fetch historical data');
  //     }
  //   } catch (e) {
  //     print('Error fetching historical data: $e');
  //   }
  // }

  // void fetchHistoricalData30() async {
  //   print("Fetching historical data");
  //   try {
  //     DateTime today = DateTime.now();
  //     DateTime dStart = today.subtract(Duration(days: 30));
  //     DateTime dEnd = today;

  //     final response = await http.get(Uri.parse(
  //         'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

  //     if (response.statusCode == 200) {
  //       final jsonString = response.body;
  //       final parsedJson = jsonDecode(jsonString);
  //       final results = parsedJson['data']['results'];
  //       List<HistoricalData> historicalDataList = List<HistoricalData>.from(
  //         results.map((json) => HistoricalData.fromJson(json)),
  //       );

  //       TabelKu.assignAll(historicalDataList.reversed);
  //       print("historical data : " + TabelKu.toString());
  //     } else {
  //       throw Exception('Failed to fetch historical data');
  //     }
  //   } catch (e) {
  //     print('Error fetching historical data: $e');
  //   }
  // }

  // Future<void> SemuaTahun() async {
  //   print("Fetching semua tahun analysis");
  //   isLoading.value = true;
  //   final token = box.read('token');
  //   print(token);
  //   final dio = Dio();
  //   dio.options.headers['Authorization'] = 'Bearer $token';

  //   final ticker = arguments['ticker'];
  //   print(ticker);

  //   try {
  //     final response = await dio.get(
  //       'http://env-4734168.user.cloudjkt01.com/api/emiten/fundamental/$ticker',
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;

  //       var Semua = jsonDecode(response.data)['data']['dataFundamental'];

  //       print("ini semua technical");
  //       print(Semua);
  //       semuatechnical = Semua;
  //       print("ini semua technical 2");
  //       print(semuatechnical);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get semua tahun 1',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     print(error);
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to semua tahun 2',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  Future<void> semuaTahunn() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      //final reportdetail = arguments['year'];
      final token = box.read('token');
      final ticker = arguments['ticker'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/emiten/fundamental/$ticker';
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua$reportdetail';

      // final token = box.read('token');
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['dataFundamental'];

        hasil = result;
        print("ini data fundamental");
        print(hasil);

        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        // final parsedJson1 = jsonDecode(parsedJson);

        final dataFundamentalList =
            jsonDecode(response.body)['data']['dataFundamental'];
        // final tahuntabel =
        //     jsonDecode(response.body)['data']['dataFundamental']['tahun'];

        // List<dynamic> dynamicList = json.decode(tahuntabel);

        print("ini data fundamental2");
        print(dataFundamentalList);
        // print("ini tahun");
        // print(dynamicList);
        List<dynamic> transformedList = [];
        List<dynamic> TAHUN = [];

        for (var sublist in dataFundamentalList) {
          transformedList.add(sublist[0]);
        }

        for (var sublist in dataFundamentalList) {
          TAHUN.add(sublist[1]);
        }

        print(transformedList);
        print('ini tahun');
        print(TAHUN);

        // List<dynamic> combinedList = [];
        // combinedList.addAll(transformedList);
        // combinedList.addAll(TAHUN);

        List<TabelValuation> tabelValuationList = List<TabelValuation>.from(
          transformedList.map((json) => TabelValuation.fromJson(json)),
        );

        DetailValuation.assignAll(tabelValuationList.reversed);
        print("historical data : " + DetailValuation.toString());

        List<TabelValuation> tahun1 = List<TabelValuation>.from(
          TAHUN.map((json) => TabelValuation.fromJson(json)),
        );

        Tahun.assignAll(tahun1.reversed);
        print("historical tahun : " + Tahun.toString());

        //-----------------------------------------------------------------------------
      } else {
        print(Error);
        Get.snackbar('Error', 'Failed to get data tabel detail',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get data tabel detail',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // SemuaTahun();
    semuaTahunn();
    //semuaTahunTabel();
    //fetchDetailValuation();
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
