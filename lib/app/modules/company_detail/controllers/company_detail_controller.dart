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
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart120.dart';
import '../../../widgets/StockChart30.dart';
import '../../../widgets/StockChart60.dart';
import '../../../widgets/StockChart90.dart';

class CompanyDetailController extends GetxController {
  final Map arguments = Get.arguments;
  // Map<String, dynamic> arguments = Get.arguments;
  final volumeC = TextEditingController();
  final hargaC = TextEditingController();
  final feeC = TextEditingController();
  final commentC = TextEditingController();
  final tanggalC = TextEditingController();
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  RxDouble feeBeli = 0.0.obs;
  RxDouble feeJual = 0.0.obs;
  var sekuritas = "".obs;
  int idSekuritas = 0;
  var role = "".obs;
  var status = "".obs;
  var laporanStatus = "".obs;
  Map<String, dynamic> company = {};
  Map<String, dynamic> tabel = {};
  List<HistoricalData> history = [];
  List<JenisSaham> jenisSaham = [];
  final DetailTechnical = <HistoricalData>[].obs;
  final historicalData30 = <HistoricalData>[].obs;
  final historicalData60 = <HistoricalData>[].obs;
  final historicalData90 = <HistoricalData>[].obs;
  final historicalData120 = <HistoricalData>[].obs;
  final ApiService apiService = ApiService();
  int selectedJenis = 1;
  List<dynamic> subsAdmin = [].obs;
  //var subsAdmin = {}.obs;
  List<dynamic> AdminStockApp = [].obs;

  //List<dynamic> HasilFinancial = [].obs;

  Map<String, dynamic> HasilFinancial = {};
  Map<String, dynamic> HasilAnalysis = {};
  List<dynamic> namaSahamKu = [];
  //Map<String, dynamic> semuatechnical = {};
  // List<dynamic> semuatechnical = [];
  //List<dynamic> HasilLaporan = [].obs;
  var namaSaham = {};

  var total_dividen = {}.obs;
  // RxList<Map<String, dynamic>> HasilLaporan = <Map<String, dynamic>>[].obs;
  //Map<String, dynamic> HasilLaporan = RxListMap<String, dynamic>{}.obs;

  var HasilLaporan = {}.obs;

// String value = "Hello";
// rxMap = value;
  var StatusUser = {}.obs;
  // var laporanStatus = {}.obs;

  Future<void> AmbilAdmin() async {
    try {
      print("Fetching all admin");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/admin';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['toFollow'];

        AdminStockApp = result;
        print("ini admin follow");
        print(AdminStockApp);
      } else {
        Get.snackbar('Error', 'Failed to get analyst ',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchSubAnalystAdmin() async {
    try {
      print("Fetching all subs ADMIN");
      isLoading.value = true;
      final token = box.read('token');
      final id = "7";
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/plan/7';
      print(apiUrl);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      //  print("Entah ${JsonEncoder.withIndent('    ').convert(response.body)}");

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['prices'];

        subsAdmin = result;
        print('ini subs admin');
        print(subsAdmin);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get subs analyst',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // void callPaymentAdmin(BuildContext context) async {
  //   try {
  //     final dio = Dio();
  //     final token = box.read('token');
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response = await dio.post(
  //       'http://env-4734168.user.cloudjkt01.com/api/createPayment',
  //       data: {
  //         "price": arguments['price'],
  //         "id_analyst": arguments['id_analyst']
  //       },
  //     );

  //     print(response);

  //     // print("ini id analyst" +
  //     //     controller.arguments['id_analyst']);

  //     // if (response.statusCode == 200) {
  //     //   final List<dynamic> data = response.data['data'];

  //     //   return data.map((item) => Tagihan.fromJson(item)).toList();
  //     // } else {
  //     //   throw Exception('Failed to load portofolio');
  //     // }
  //     MidtransPayment.loadRequest(Uri.parse(response.data['redirect_url']));
  //     //Get.toNamed(MIDTRANS);
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  //   Get.defaultDialog(
  //       backgroundColor: primary,
  //       title: "",
  //       content: Container(
  //           //height: 400,
  //           height: 500,
  //           width: MediaQuery.of(context).size.width,
  //           child: WebViewWidget(controller: MidtransPayment)));
  // }

  // var MidtransPayment = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setBackgroundColor(const Color(0x00000000))
  //   ..setNavigationDelegate(
  //     NavigationDelegate(
  //       onProgress: (int progress) {
  //         // Update loading bar.
  //       },
  //       onPageStarted: (String url) {},
  //       onPageFinished: (String url) async {
  //         final box = GetStorage();

  //         print("ini apalah url" + url);
  //         if (url.contains("http://example.com/finish")) {
  //           print("berhasil bayar");
  //           var uri = Uri.parse(url);
  //           // /subscribe/setPaid/

  //           final dio = Dio();
  //           final token = box.read('token');
  //           final id = uri.queryParameters['order_id'];
  //           print("order id $id");
  //           dio.options.headers['Authorization'] = 'Bearer $token';
  //           final response = await dio.post(
  //             'http://env-4734168.user.cloudjkt01.com/api/subscribe/setPaid/$id',
  //           );
  //           print(response);
  //           Get.back();
  //           Get.back();
  //           Get.back();
  //         }
  //       },
  //       onWebResourceError: (WebResourceError error) {},
  //       onNavigationRequest: (NavigationRequest request) {
  //         if (request.url.startsWith('https://www.youtube.com/')) {
  //           return NavigationDecision.prevent;
  //         }
  //         return NavigationDecision.navigate;
  //       },
  //     ),
  //   )
  //   ..loadRequest(Uri.parse('https://flutter.dev'));

  void ThirtyDays(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: primary,
      title: "30 Days",
      content: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: StockChart30(),
          )),
    );
    // Container(
    //   width: Get.width * 2,
    //   height: Get.height * .4,
    //   child: SingleChildScrollView(
    //       controller: ScrollController(),
    //       scrollDirection: Axis.horizontal,
    //       child: Container(
    //         height: 500,
    //         width: MediaQuery.of(context).size.width,
    //         child: StockChart30(),
    //       )),
    // );
  }

  void SixtyDays(BuildContext context) {
    // Container(
    //   width: Get.width * 2,
    //   height: Get.height * .4,
    //   child: SingleChildScrollView(
    //     controller: ScrollController(),
    //     scrollDirection: Axis.horizontal,
    //     child: StockChart60(),
    //     // child: Container(
    //     //   height: 500,
    //     //   width: MediaQuery.of(context).size.width,

    //     // )
    //   ),
    // );
    Get.defaultDialog(
      backgroundColor: primary,
      title: "60 Days",
      content: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: StockChart60(),
          )),
    );
  }

  void NinetyDays(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: primary,
      title: "90 Days",
      content: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: StockChart90(),
          )),
    );
  }

  void OneHundredAndTwentyDays(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: primary,
      title: "120 Days",
      content: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: StockChart120(),
          )),
    );
  }

  //List<dynamic> HasilAnalystFinancial = [].obs;
  //dynamic HasilAnalystFinancial = [].obs;

  Future<void> saveTransaction(String type, String id, double fee) async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDate = formatter.format(now);
    if (volumeC.text == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi volume',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    double total =
        ((double.parse(hargaC.text) * double.parse(volumeC.text)) * fee) / 100;

    if (total > 10000000) {
      double totalfinal =
          ((double.parse(hargaC.text) * double.parse(volumeC.text)) * fee) +
              10000;
      print("Total1 : " + totalfinal.toString());
    } else {
      double totalfinal =
          ((double.parse(hargaC.text) * double.parse(volumeC.text)) * fee) /
              100;
      print("Total2 : " + totalfinal.toString());
    }

    //hargaC.text = "69";

    // double totalfinal = total;
    print("Total : " + total.toString());

    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      // all = hargaC.text + total;
      print({
        'id_saham': id,
        'tanggal': tanggalC.text,
        'volume': int.parse(volumeC.text),
        'jenis': selectedJenis,
        'type': type,
        'harga': int.parse(hargaC.text),
        'fee': fee,
        'id_sekuritas': idSekuritas
      });
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio/add',
        data: {
          'id_saham': id,
          'tanggal': tanggalC.text,
          'volume': int.parse(volumeC.text),
          'jenis': selectedJenis,
          'type': type,
          'harga': int.parse(hargaC.text),
          'feeku': fee,
          'id_sekuritas': idSekuritas
        },
      );
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        // if (type == 'beli') {
        //   Get.toNamed(Routes.TAGIHAN);
        // } else {
        //   Get.back();
        // }

        Get.snackbar('Berhasil', 'Data $type berhasil disimpan',
            backgroundColor: Colors.green);
      } else {
        isSending.value = false;
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  void showTable(String status) {
    Get.defaultDialog(title: "test");
  }

  void showDialog(double price, String type, double feeBeli, double feeJual,
      String sekuritas, int sekuritasID, BuildContext context) {
    double fee = 0;

    if (type == 'beli') {
      fee = feeBeli;
    } else {
      fee = feeJual;
    }

    Get.defaultDialog(
        backgroundColor: primary,
        title: type.toUpperCase() + " SAHAM " + arguments['ticker'],
        titlePadding: EdgeInsets.all(5),
        content: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            color: primary,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Sekuritas"),
                Text(
                  sekuritas,
                  style: TextStyle(
                      color: Colors.redAccent[400],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fee"),
                        Text(
                          fee.toString(),
                          style: TextStyle(
                              color: Colors.redAccent[400],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Harga $type"),
                        Container(
                          width: Get.width / 3.5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: hargaC,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 13.0),
                              hintText: 'Masukkan harga $type',
                              hintStyle: TextStyle(fontSize: 11.0),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // Text("Tanggal $type"),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tanggal $type"),
                        Container(
                          width: Get.width / 3.3,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller:
                                tanggalC, //editing controller of this TextField
                            // decoration: InputDecoration(
                            //   // icon: Icon(Icons.calendar_today,
                            //   //     size: 15), //icon of text field
                            //   hintText: 'Enter $type date',
                            //   labelStyle: TextStyle(
                            //     fontSize:
                            //         13, // Atur ukuran font label dalam TextField
                            //   ), //label text of field

                            // ),

                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 13.0),
                              hintText: 'Enter $type date',
                              hintStyle: TextStyle(fontSize: 11.0),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                            ),

                            // readOnly:
                            //     true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate1 =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate1); //formatted date output using intl package =>  2021-03-16

                                tanggalC.text =
                                    formattedDate1; //set output date to TextField value.
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Text("Jenis Saham"),
                FutureBuilder(
                  future: fetchJenis(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Failed to fetch jenis saham');
                    } else {
                      return Container(
                          width: Get.width,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            value: jenisSaham.isEmpty
                                ? null
                                : jenisSaham[0].id_jenis_saham,
                            items: List.generate(jenisSaham.length, (index) {
                              return DropdownMenuItem(
                                value: jenisSaham[index].id_jenis_saham,
                                child: Text(jenisSaham[index].jenis_saham),
                              );
                            }),
                            onChanged: (value) {
                              selectedJenis = value!;
                              // Handle onChanged event
                            },
                          ));
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Volume $type"),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: volumeC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 13.0),
                      hintText: 'Masukkan volume $type',
                      hintStyle: TextStyle(fontSize: 11.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   width: Get.width / 8,
                //   child: TextField(
                //     controller: tanggalC, //editing controller of this TextField
                //     decoration: InputDecoration(
                //         icon: Icon(Icons.calendar_today), //icon of text field
                //         labelText: "Enter Date" //label text of field
                //         ),
                //     readOnly:
                //         true, //set it true, so that user will not able to edit text
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(
                //               2000), //DateTime.now() - not to allow to choose before today.
                //           lastDate: DateTime(2101));

                //       if (pickedDate != null) {
                //         print(
                //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                //         String formattedDate1 =
                //             DateFormat('yyyy-MM-dd').format(pickedDate);
                //         print(
                //             formattedDate1); //formatted date output using intl package =>  2021-03-16

                //         tanggalC.text =
                //             formattedDate1; //set output date to TextField value.
                //       } else {
                //         print("Date is not selected");
                //       }
                //     },
                //   ),
                // ),
                // Obx(() => role == 'Analyst'
                //     ? Container(
                //         margin: EdgeInsets.only(top: 10),
                //         width: Get.width,
                //         decoration: BoxDecoration(
                //           color: Colors.grey[300],
                //         ),
                //         child: TextField(
                //           maxLines: 5,
                //           controller: commentC,
                //           decoration: InputDecoration(
                //             labelStyle: TextStyle(fontSize: 13.0),
                //             hintText: 'Masukkan Komentar Anda',
                //             hintStyle: TextStyle(fontSize: 11.0),
                //             border: InputBorder.none,
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: 16.0, vertical: 12.0),
                //           ),
                //         ),
                //       )
                //     : SizedBox()),
                Obx(() => Container(
                    width: Get.width,
                    child: isSending.value == false
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 80.0, right: 80.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    // shape: StadiumBorder(),
                                    backgroundColor: Colors.redAccent[400]),
                                onPressed: () async {
                                  saveTransaction(type, arguments['ticker'],
                                      fee.toDouble());
                                  // await initializeNotifications();
                                  //               await showNotification();
                                },
                                child: Text("Save")),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )))
              ],
            ),
          ),
        ));
  }

  void Chart() {
    Container(
        width: Get.width / 2.6,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 20),
                // shape: StadiumBorder(),
                backgroundColor: Colors.green),
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder:
              //       (BuildContext context) {
              //     return SekuritasModalSheet(
              //         apiService: apiService,
              //         trxType: 'beli',
              //         controller: controller,
              //         price: double.parse(
              //             data['last_price']
              //                 ['open']));
              //   },
              // );
            },
            child: Text("30 Days")));
  }

  // Future<void> initializeNotifications() async {
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('@mipmap/ic_launcher');
  //   // const AndroidInitializationSettings initializationSettingsAndroid =
  //   //     AndroidInitializationSettings('app_icon');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //   await flutterLocalNotificationsPlugin?.initialize(initializationSettings);
  // }

  // Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('your_channel_id', 'your_channel_name',
  //           importance: Importance.max, priority: Priority.high);
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin?.show(
  //     0,
  //     'Berhasi',
  //     'Ini adalah contoh notifikasi',
  //     platformChannelSpecifics,
  //   );
  // }
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();

  void fetchDetailTechnical() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 7));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${arguments['dateStart']}&to=${arguments['dateEnd']}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));
      //  'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${arguments['startdate']}&to=${arguments['enddate']}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

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

  void fetchHistoricalData30() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 30));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        print("ini result");
        print(results);
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        historicalData30.assignAll(historicalDataList.reversed);
        print("historical data : " + historicalData30.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  void fetchHistoricalData60() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 60));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        historicalData60.assignAll(historicalDataList.reversed);
        print("historical data : " + historicalData60.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  void fetchHistoricalData90() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 90));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        historicalData90.assignAll(historicalDataList.reversed);
        print("historical data : " + historicalData90.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  void fetchHistoricalData120() async {
    print("Fetching historical data");
    try {
      DateTime today = DateTime.now();
      DateTime dStart = today.subtract(Duration(days: 120));
      DateTime dEnd = today;

      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/${arguments['ticker']}/historical?from=${dStart.toString()}&to=${dEnd.toString()}&api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final results = parsedJson['data']['results'];
        List<HistoricalData> historicalDataList = List<HistoricalData>.from(
          results.map((json) => HistoricalData.fromJson(json)),
        );

        historicalData120.assignAll(historicalDataList.reversed);
        print("historical data : " + historicalData120.toString());
      } else {
        throw Exception('Failed to fetch historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  // Future<void> AnalysisFinancial2() async {
  //   try {
  //     print("Fetching all analysis fincancial");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     final ticker = arguments['ticker'];
  //     print(ticker);
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/emiten/$ticker';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     // print("Entah ${JsonEncoder.withIndent('    ').convert(response.body)}");

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       HasilAnalystFinancial = result;
  //       print('ini analyst financial');
  //       print(HasilAnalystFinancial);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get subs analyst',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  Future<void> fetchJenis() async {
    final String apiUrl = 'http://env-4734168.user.cloudjkt01.com/api';
    final dio = Dio();
    final box = GetStorage();
    final token = box.read('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('${apiUrl}/portofolio/jenis');

      final results = response.data['data'];
      List<JenisSaham> jenisSahamList = List<JenisSaham>.from(
        results.map((json) => JenisSaham.fromJson(json)),
      );

      jenisSaham.assignAll(jenisSahamList);
      print("jenis saham " + jenisSaham.toString());
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> Analysis() async {
    print("Fetching analysis");
    isLoading.value = true;
    final token = box.read('token');
    print(token);
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    final ticker = arguments['ticker'];
    print(ticker);

    try {
      isLoading.value = true;
      final response = await dio.get(
        'http://env-4734168.user.cloudjkt01.com/api/emiten/$ticker',
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var total_dividen = "ayam";
        print("ini total dividen");
        print(total_dividen);

        var Inputresults = (response.data)['data']['inputData'];
        var namaSaham = (response.data)['data']['inputData']['nama_saham'];

        var results = (response.data)['data']['outputData'];
        //var resussslts = (response.data)['data']['outputData'];

        var Laporan = (response.data)['data']['laporan'];

        //var Semua = (response.data)['data'];

        //var bisa = jsonDecode(jsonEncode(Laporan));

        //jsonEncode(Laporan);
        //RxMap<dynamic, dynamic> d = jsonDecode(Laporan);

        // ar result = jsonDecode(response.body)['data']['toFollow'];
        // print("ini RESULT");
        // RxMap<dynamic, dynamic> nama = RxMap<dynamic, dynamic>.from(namaSaham);

        RxMap<dynamic, dynamic> rxMap = RxMap<dynamic, dynamic>.from(Laporan);

        print("ini nama saham");
        print(namaSaham);
        // namaSahamKu = nama;

        print("ini hasil analysis output");
        print(results);
        HasilFinancial = results;
        print("ini hasil analysis input");
        print(Inputresults);
        HasilAnalysis = Inputresults;
        // print("ini semua technical");
        // print(Semua);
        // semuatechnical = Semua;
        print("ini laporan");
        print(rxMap);
        HasilLaporan.value = rxMap;
        HasilLaporan.refresh();
        print("ini hasil laporan");
        print(HasilLaporan);
        //if Laporan is not null then
        // String jsonString = json.encode(HasilAnalystFinancial);
        // print("ini hasil technical yg json");
        // print(jsonString);
        //print("ini analyss financial $HasilAnalystFinancial");
      } else {
        Get.snackbar('Error', 'Failed to get technical1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get technical2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> SemuaTahun() async {
    print("Fetching semua tahun analysis");
    isLoading.value = true;
    final token = box.read('token');
    print(token);
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    final ticker = arguments['ticker'];
    print(ticker);

    try {
      final response = await dio.get(
        'http://env-4734168.user.cloudjkt01.com/api/emiten/fundamental/$ticker',
        //emiten/{emiten}/fundamental
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        // var total_dividen = "ayam";
        // print("ini total dividen");
        // print(total_dividen);

        // var Inputresults = (response.data)['data']['inputData'];

        // var results = (response.data)['data']['outputData'];
        // //var resussslts = (response.data)['data']['outputData'];

        // var Laporan = (response.data)['data']['laporan'];

        var Semua = (response.data)['data']['dataFundamental'];
        // print("ini semua technical");
        // print(Semua);

        //var bisa = jsonDecode(jsonEncode(Laporan));

        //jsonEncode(Laporan);
        //RxMap<dynamic, dynamic> d = jsonDecode(Laporan);

        // ar result = jsonDecode(response.body)['data']['toFollow'];
        // print("ini RESULT");

        // RxMap<dynamic, dynamic> rxMap = RxMap<dynamic, dynamic>.from(Laporan);

        // print("ini hasil analysis output");
        // print(results);
        // HasilFinancial = results;
        // print("ini hasil analysis input");
        // print(Inputresults);
        // HasilAnalysis = Inputresults;

        // print("ini semua technical");
        // print(Semua);
        // semuatechnical = Semua;

        // print("ini laporan");
        // print(rxMap);
        // HasilLaporan.value = rxMap;
        // HasilLaporan.refresh();
        // print("ini hasil laporan");
        // print(HasilLaporan);
        //if Laporan is not null then
        // String jsonString = json.encode(HasilAnalystFinancial);
        // print("ini hasil technical yg json");
        // print(jsonString);
        //print("ini analyss financial $HasilAnalystFinancial");
      } else {
        Get.snackbar('Error', 'Failed to get semua tahun 1',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to semua tahun 2',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void fetchDetail() async {
    print("Fetching companies");
    // Financial();
    // Analysis();
    fetchSubAnalystAdmin();

    try {
      isLoading.value = true;

      final emitence = arguments['ticker'];
      final response = await http.get(Uri.parse(
          'https://api.goapi.id/v1/stock/idx/$emitence?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        company = result;
        //  Analysis();
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  // void fetchTabel() async {
  //   print("Fetching tabel");

  //   try {
  //     isLoading.value = true;
  //     final ticker = arguments['ticker'];

  //     final response = await http
  //         .get(Uri.parse('http://env-4734168.user.cloudjkt01.com/api/emiten/{$ticker}'));
  //     print("ini mau print tabel");

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       //fetchDetail();
  //       var result = jsonDecode(response.body)['data'];
  //       print("ini hasil tabel");
  //       tabel = result;
  //       print(tabel);
  //     } else {
  //       throw Exception('Failed to load companies');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    Analysis();
    //SemuaTahun();
    role.value = box.read("role");
    AmbilAdmin();
    fetchDetail();
    fetchSubAnalystAdmin();
    fetchDetailTechnical();

    // AnalysisFinancial();
    //fetchTabel();
    // AnalysisFinancial();
    // fetchJenis();
    fetchHistoricalData30();
    fetchHistoricalData60();
    fetchHistoricalData90();
    fetchHistoricalData120();
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
