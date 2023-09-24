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

class TechnicalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();
  final searchC = TextEditingController();
  var isLoading = false.obs;
  var isSending = false.obs;
  //List<dynamic> abc = [].obs;
  var valueStockTrend = 0.obs;
  List<JenisTrend> jenisTrend = [];
  int number = 20;

  //List<String> inputHistory = [];

  String? selectedValueTrend;
  String? selectedValueParam;
  String? selectedValueComparison;
  String? selectedPeriod;
  List<String> selectedValues = [];
  //String percentController;

  String? selectedValueParamDer;
  TextEditingController percentControllerDer = TextEditingController();
  String? selectedValueComparisonDer;

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

  List<String> inputHistory = [];

  // ... (other methods)

  String getInputHistoryJson() {
    return json.encode(inputHistory);
  }

  void updateInputHistory(List<String> updatedInputHistory) {
    inputHistory = updatedInputHistory;
    update(); // Rebuild the widget
  }

  //print(updatedInputHistoryy);

  Future<void> upload() async {
    int nTrend = valueStockTrend.value;
  }

  final stockTrendC = TextEditingController();
  final fundamentalC = TextEditingController();
  final lessThanC = TextEditingController();
  final percentC = TextEditingController();
  final startDateC = TextEditingController();
  final endDateC = TextEditingController();

  Future<void> fetchTechnical(Map<String, List<String>> dynamicValues) async {
    print("Fetching technical");
    isLoading.value = true;

    // List<String>? dividenList = dynamicValues['dividen'];
    // print("coba print list dividen");
    // print(dividenList);
    String apiUrl =
        'http://env-4734168.user.cloudjkt01.com/api/search/technical/saham?';

    if (dynamicValues['der'] != null) {
      apiUrl += '&param_der=${dynamicValues['der']!.join(',')}&';
    }

    if (dynamicValues['loan_to_depo_ratio'] != null) {
      apiUrl +=
          '&param_loan_to_depo_ratio=${dynamicValues['loan_to_depo_ratio']!.join(',')}&';
    }

    if (dynamicValues['annualized_roe'] != null) {
      apiUrl +=
          '&param_annualized_roe=${dynamicValues['annualized_roe']!.join(',')}&';
    }

    if (dynamicValues['annualized_per'] != null) {
      apiUrl +=
          '&param_annualized_per=${dynamicValues['annualized_per']!.join(',')}&';
    }

    if (dynamicValues['dividen'] != null) {
      apiUrl += '&param_dividen=${dynamicValues['dividen']!.join(',')}&';
    }

    if (dynamicValues['dividen_yield'] != null) {
      apiUrl +=
          '&param_dividen_yield=${dynamicValues['dividen_yield']!.join(',')}&';
    }

    if (dynamicValues['dividen_payout_ratio'] != null) {
      apiUrl +=
          '&param_dividen_payout_ratio=${dynamicValues['dividen_payout_ratio']!.join(',')}&';
    }

    if (dynamicValues['pbv'] != null) {
      apiUrl += '&param_pbv=${dynamicValues['pbv']!.join(',')}&';
    }

    if (dynamicValues['annualized_roa'] != null) {
      apiUrl +=
          '&param_annualized_roa=${dynamicValues['annualized_roa']!.join(',')}&';
    }

    if (dynamicValues['gpm'] != null) {
      apiUrl += '&param_gpm=${dynamicValues['gpm']!.join(',')}&';
    }

    if (dynamicValues['npm'] != null) {
      apiUrl += '&param_npm=${dynamicValues['npm']!.join(',')}&';
    }

    if (dynamicValues['eer'] != null) {
      apiUrl += '&param_eer=${dynamicValues['eer']!.join(',')}&';
    }

    if (dynamicValues['ear'] != null) {
      apiUrl += '&param_ear=${dynamicValues['ear']!.join(',')}&';
    }

    if (dynamicValues['market_cap'] != null) {
      apiUrl += '&param_market_cap=${dynamicValues['market_cap']!.join(',')}&';
    }

    if (dynamicValues['market_cap_asset_ratio'] != null) {
      apiUrl +=
          '&param_market_cap_asset_ratio=${dynamicValues['market_cap_asset_ratio']!.join(',')}&';
    }

    if (dynamicValues['cfo_sales_ratio'] != null) {
      apiUrl +=
          '&param_cfo_sales_ratio=${dynamicValues['cfo_sales_ratio']!.join(',')}&';
    }

    if (dynamicValues['capex_cfo_ratio'] != null) {
      apiUrl +=
          '&param_capex_cfo_ratio=${dynamicValues['capex_cfo_ratio']!.join(',')}&';
    }

    if (dynamicValues['market_cap_cfo_ratio'] != null) {
      apiUrl +=
          '&param_market_cap_cfo_ratio=${dynamicValues['market_cap_cfo_ratio']!.join(',')}&';
    }

    if (dynamicValues['peg'] != null) {
      apiUrl += '&param_peg=${dynamicValues['peg']!.join(',')}&';
    }

    if (dynamicValues['harga_saham_sum_dividen'] != null) {
      apiUrl +=
          '&param_harga_saham_sum_dividen=${dynamicValues['harga_saham_sum_dividen']!.join(',')}&';
    }

    final token = "63|y1GCKZIz4NcYoRK9Wug6MwmNREAAPhNJKE82QM1S";
    print(token);
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    apiUrl +=
        'trend=$selectedValueTrend&type=$selectedPeriod&start=${dateStart.text}&end=${dateEnd.text}';

    try {
      final response = await dio.get(
        //Jika menggunakan android emulator maka URL API menjadi http://10.0.2.2, bukan http://127.0.0.1
        apiUrl,
      );
      print(apiUrl);
      //print("a");

      if (response.statusCode == 200) {
        isLoading.value = false;
        print('sukses');
        print(apiUrl);
        // print(
        //     'http://env-4734168.user.cloudjkt01.com/api/search/technical/saham?&trend=$selectedValueTrend&type=$selectedPeriod&start=${dateStart.text}&end=${dateEnd.text}&param_der=$arrayStringDer&param_gpm=$arrayStringGpm&param_npm=$arrayStringNpm');

        print("apa aja boel");
        var results = (response.data)['data'];
        print("ini hasil technical");
        print(results);

        var tahun = (response.data)['tahun'];
        print("ini hasil technical tahun");
        print(tahun);

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
      print('gagal');
      print(apiUrl);
      // print(
      //     'http://env-4734168.user.cloudjkt01.com/api/search/technical/saham?&trend=$selectedValueTrend&type=$selectedPeriod&start=${dateStart.text}&end=${dateEnd.text}&param_der=$arrayStringDer&param_gpm=$arrayStringGpm&param_npm=$arrayStringNpm');
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get technical2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    print("dwdwdwd");

    // print(
    //     'http://env-4734168.user.cloudjkt01.com/api/search/technical/saham?&trend=$selectedValueTrend&param_dividen=$arrayStringDer');

    //  }
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
        title: " TECHNICAL"
        //  +
        //     selectedValueParam! +
        //     selectedValueComparison! +
        //     percentController.text
        ,
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
              for (String inputText in inputHistory) {
                List<String> parts = inputText.split(',');
                if (parts.length == 3) {
                  String firstValue = parts[0];
                  String comparisonValue = parts[1];
                  String percentValue = parts[2];

                  // // Ambil selectedValueParam yang dipilih
                  // String selectedValueParam = firstValue;

                  // // Buat nama variabel sesuai dengan selectedValueParam
                  // String dynamicListName = selectedValueParam;

                  // // Buat list baru jika belum ada
                  // if (!dynamicValues.containsKey(dynamicListName)) {
                  //   dynamicValues[dynamicListName] = [];
                  // }

                  // // Tambahkan nilai inputHistory ke dalam list yang sesuai
                  // String dynamicText =
                  //     '$firstValue,$comparisonValue,$percentValue';
                  // dynamicValues[dynamicListName]?.add(dynamicText);
                }
              }
              return ListView.builder(
                  itemCount: HasilTechnical.length,
                  itemBuilder: (context, index) {
                    //  print("ini technical tabewdwdl $HasilTechnical");
                    final abc = HasilTechnical[index];
                    final formatter = NumberFormat('#,###');

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          color: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(abc['tahun'].toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          Text("-" + abc['type'].toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Get.defaultDialog(content: Container()
                                              //     //ThirtyDays(context)
                                              //     );
                                              //Get.toNamed(Routes.DETAIL_TECHNICAL);

                                              Get.toNamed(
                                                  Routes.DETAIL_TECHNICAL,
                                                  arguments: {
                                                    'ticker': abc['ticker'],
                                                    'dateStart':
                                                        abc['startdate'],
                                                    'dateEnd': abc['enddate'],
                                                    //   'name': company['name'],
                                                  });
                                              // tampildata;
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                fixedSize: Size(50, 5),
                                                backgroundColor: buttoncolor),
                                            child: Text('detail',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ),
                                        ],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Moving AVG'),
                                          Text(
                                              abc['MAPercentage'].toString() +
                                                  "%",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 65),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Trend Change'),
                                          Text(abc['change'].toString() + "%",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                              )),
                                        ],
                                      ),
                                      // SizedBox(width: 90),
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
                                      //                   Column(
                                      //                     mainAxisAlignment:
                                      //                         MainAxisAlignment.start,
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment.start,
                                      //                     children: [
                                      //                       ListView.builder(shrinkWrap: true,
                                      // itemCount: Tampil.length,
                                      // itemBuilder: (context, index) {}),
                                      //                       Text(selectedValueParam!),
                                      //                       Text(
                                      //                           abc['$selectedValueParam']
                                      //                                   .toString() +
                                      //                               "%",
                                      //                           style: TextStyle(
                                      //                             color: Colors.black87,
                                      //                             fontSize: 15,
                                      //                           )),
                                      //                     ],
                                      //                   ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(selectedValueParam!),
                                      //     Text(
                                      //         abc['$selectedValueParam']
                                      //                 .toString() +
                                      //             "%",
                                      //         style: TextStyle(
                                      //           color: Colors.black87,
                                      //           fontSize: 15,
                                      //         )),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))),
                    );
                  });
            })
            // },
            // );
            // }
            // ),
            // })

            ));
  }

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
