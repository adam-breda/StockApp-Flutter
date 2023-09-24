import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:stock_app/app/modules/dashboard/controllers/technical_controller.dart';
import 'package:stock_app/app/routes/app_pages.dart';
import 'package:stock_app/core.dart';

import '../../../Values/values.dart';
import '../../../models/JenisTechnical/JenisTrend.dart';
import '../../../widgets/Technical.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controllers/technical_backup_controller.dart';
import 'fundamental_view.dart';

class JenisTrend {
  final String value;
  final String label;

  JenisTrend({required this.value, required this.label});

  List<JenisTrend> JenisTrends = [
    JenisTrend(value: '>', label: 'More Than'),
    JenisTrend(value: '<', label: 'Less Than'),
  ];
}

class TechnicalView extends GetView<TechnicalBackupController> {
  //TechnicalView({Key? key}) : super(key: key);
  TechnicalBackupController controller = Get.put(TechnicalBackupController());
  //final TextEditingController trendController = new TextEditingController();
  ValueNotifier<String> trendController = ValueNotifier<String>('');
  TextEditingController dropdownController = TextEditingController();

  //TextEditingController percentController = TextEditingController();

  List<String> dropdownValue = [
    "Uptrend",
    "Downtrend",
    "Sideways",
  ];

  List<String> StockTrend = [
    "Uptrend",
    "Downtrend",
    "Sideways",
  ];

  List<String> Fundamental = [
    "Debt to Equity Ratio",
    "Loan to Deposit Ratio",
  ];

  List<String> LessMore = [
    "Less Than",
    "More Than",
  ];

  final List<String> fundamentalOptions = [
    'der',
    'loa',
    'per',
    // ... Add other options
  ];

  //TextEditingController dateStart = TextEditingController();
  final List<String> inputHistory;
  //final List<dynamic> inputHistory;

  TechnicalView({required this.inputHistory, required String inputHistoryJson});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          "Technical",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the specific tab in the bottom navigation bar
            Navigator.popUntil(
                context,
                ModalRoute.withName(
                    '/home')); // Replace '/home' with your route name
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stock Trend',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 220,
                        child: DropdownButtonFormField<String>(
                          value: controller
                              .selectedValueTrend, // Nilai dropdown yang dipilih
                          onChanged: (newValue) {
                            controller.selectedValueTrend =
                                newValue!; // Mengubah nilai dropdown yang dipilih
                          },
                          items: <String>[
                            'All',
                            'Uptrend',
                            'Downtrend',
                            'Sideways',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  value), // Teks yang akan ditampilkan pada dropdown
                            );
                          }).toList(),
                          // decoration: InputDecoration(
                          //   // labelText: 'Pilih Trend', // Label untuk dropdown
                          //   border: OutlineInputBorder(),
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),

                  // Divider(
                  //   color: Colors.black,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: TextField(
                          controller: controller
                              .dateStart, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
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

                              controller.dateStart.text =
                                  formattedDate1; //set output date to TextField value.
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  // Divider(
                  //   color: Colors.black,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: TextField(
                          controller: controller
                              .dateEnd, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
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
                              String formattedDate2 =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate2); //formatted date output using intl package =>  2021-03-16

                              controller.dateEnd.text =
                                  formattedDate2; //set output date to TextField value.
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.FUNDAMENTAL);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(350, 20),
                        backgroundColor: secondary),
                    child: Text(
                      'Fundamental',
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: inputHistory.length,
                    itemBuilder: (context, index) {
                      final aFundamental = inputHistory[index];
                      // final fundamental = aFundamental['Fundamental'];
                      return ListTile(
                        title: Text(inputHistory[index]),
                        // subtitle: Text(fundamental),
                      );
                    },
                  ),

                  SizedBox(
                    height: 220,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.fetchTechnical(
                              //percentController.text,
                              );
                          controller.tampildata(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(100, 20),
                            backgroundColor: buttoncolor),
                        child: Text('Submit'),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final inputHistory =
      //         await Get.to<List<String>>(() => FundamentalView());

      //     if (inputHistory != null) {
      //       // Do something with the inputHistory data
      //     }
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.brown,
      // ),
    );
  }
}
