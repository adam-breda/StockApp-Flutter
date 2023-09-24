import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../models/JenisTechnical/JenisTrend.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart30.dart';
import '../../../widgets/Technical.dart';

class TechnicalBackupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();
  final searchC = TextEditingController();
  var isLoading = false.obs;
  var isSending = false.obs;
  //List<dynamic> abc = [].obs;
  var valueStockTrend = 0.obs;
  List<JenisTrend> jenisTrend = [];
  int number = 20;

  String? selectedValueTrend;
  String? selectedValueParam;
  String? selectedValueComparison;
  //String percentController;

  var trend = "".obs;
  var valueAbc = 0.obs;
  var valueFundamental = 0.obs;
  var valueLessmore = 0.obs;
  List<dynamic> TrendPortos = [].obs;
  var name = "".obs;
  var role = "".obs;
  var initPage = "Top Loser".obs;
  var initokenpostman = "63|y1GCKZIz4NcYoRK9Wug6MwmNREAAPhNJKE82QM1S";
  //DateTime? selectedDate;
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController percentController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  dynamic HasilTechnical = [];
  List<dynamic> abc = [].obs;
  //List<dynamic> tabelTechnical = [];
  List<dynamic> tabelTechnical = [].obs;

  //fungsi untuk mengload Data pada tanggal

  // String stockTrend = '';
  // String fundamental = '';
  // String lessThan = '';
  // String percent = '';
  // String startDate = '';
  // String endDate = '';

  Future<void> upload() async {
    int nTrend = valueStockTrend.value;
  }

  final stockTrendC = TextEditingController();
  final fundamentalC = TextEditingController();
  final lessThanC = TextEditingController();
  final percentC = TextEditingController();
  final startDateC = TextEditingController();
  final endDateC = TextEditingController();

  Future<void> fetchTechnical() async {
    print("Fetching technical");
    isLoading.value = true;
    final token = "63|y1GCKZIz4NcYoRK9Wug6MwmNREAAPhNJKE82QM1S";
    print(token);
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await dio.get(
        //Jika menggunakan android emulator maka URL API menjadi http://10.0.2.2, bukan http://127.0.0.1
        'http://env-4734168.user.cloudjkt01.com/api/search/technicallama/saham?&trend=$selectedValueTrend&param=$selectedValueParam&comparison=$selectedValueComparison&num=${percentController.text}&start=${dateStart.text}&end=${dateEnd.text}',
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        print(
            'http://env-4734168.user.cloudjkt01.com/api/search/technicallama/saham?&trend=$selectedValueTrend&param=$selectedValueParam&comparison=$selectedValueComparison&num=${percentController.text}&start=${dateStart.text}&end=${dateEnd.text}');
        print("apa aja boel");
        var results = (response.data)['data'];
        print("ini hasil technical");
        print(results);
        HasilTechnical = results;

        abc = HasilTechnical;

        print("ini technical tabel $HasilTechnical");
      } else {
        Get.snackbar('Error', 'Failed to get technical1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      // print('ini url');
      // print(
      //     'http://env-4734168.user.cloudjkt01.com/api/search/technical/saham?&trend=$selectedValueTrend&param=$selectedValueParam&comparison=$selectedValueComparison&num=${percentController.text}&start=${dateStart.text}&end=${dateEnd.text}');
      // print("ini error $error");
      // print("ini token $token");
      // print("ini trend $selectedValueTrend");
      // print("ini fundamental $selectedValueParam");
      // print("ini lessmore $selectedValueComparison");
      // print("ini num ${percentController.text}");
      // print("ini start ${dateStart.text}");
      // print("ini end ${dateEnd.text}");

      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get technical2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void ThirtyDays(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: primary,
      title: "",
      content: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: StockChart30(),
          )),
    );
  }

  final formatter = NumberFormat('#,###');

  void tampildata(BuildContext context) {
    Get.defaultDialog(
        backgroundColor: primary,
        title: " TECHNICAL " + selectedValueParam!,
        content: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            // scrollable: true,
            color: primary,
            child: Obx(() {
              if (isLoading.value == true) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.redAccent[400],
                ));
              }
              return ListView.builder(
                  itemCount: HasilTechnical.length,
                  itemBuilder: (context, index) {
                    print("ini technical tabewdwdl $HasilTechnical");
                    final abc = HasilTechnical[index];
                    final formatter = NumberFormat('#,###');

                    return Card(
                        color: secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(abc['ticker'].toString(),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(abc['tahun'].toString(),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Get.defaultDialog(content: Container()
                                      //     //ThirtyDays(context)
                                      //     );
                                      //Get.toNamed(Routes.DETAIL_TECHNICAL);

                                      Get.toNamed(Routes.DETAIL_TECHNICAL,
                                          arguments: {
                                            'ticker': abc['ticker'],
                                            'dateStart': abc['startdate'],
                                            'dateEnd': abc['enddate'],
                                            //   'name': company['name'],
                                          });
                                      // tampildata;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        fixedSize: Size(50, 5),
                                        backgroundColor: buttoncolor),
                                    child: Text('detail',
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('MA Change'),
                                      Text(abc['MAPercentage'].toString() + "%",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 65),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Trend'),
                                      Text(abc['trend'].toString(),
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Change'),
                                      Text(abc['change'].toString() + "%",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 90),
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text('DER'),
                                  //     Text(abc['der'].toString() + "%",
                                  //         style: TextStyle(
                                  //           color: Colors.black87,
                                  //           fontSize: 15,
                                  //         )),
                                  //   ],
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(selectedValueParam!),
                                      Text(
                                          abc['$selectedValueParam']
                                                  .toString() +
                                              "%",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )));
                  });
            })
            // },
            // );
            // }
            // ),
            // })

            ));
  }

  // void showDialog() {
  //   Get.defaultDialog(tampildata());
  // }

  // void showDialog() {
  //   Get.defaultDialog(title: " TECHNICAL ", content: Container());
  // }

  // Future<void> _selectDate(context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    //fetchTrends();
    print("ini technical");
    //fetchTechnical(trend,);
    // fetchTechnical();
    print("ini technical lg");
    //_selectDate('');
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
