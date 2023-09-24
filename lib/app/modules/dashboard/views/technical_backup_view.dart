import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/modules/dashboard/controllers/technical_controller.dart';
import 'package:stock_app/app/routes/app_pages.dart';

import '../../../Values/values.dart';
import '../../../models/JenisTechnical/JenisTrend.dart';
import '../../../widgets/Technical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/technical_backup_controller.dart';

class JenisTrend {
  final String value;
  final String label;

  JenisTrend({required this.value, required this.label});

  List<JenisTrend> JenisTrends = [
    JenisTrend(value: '>', label: 'More Than'),
    JenisTrend(value: '<', label: 'Less Than'),
  ];
}

class TechnicalBackupView extends GetView<TechnicalBackupController> {
  TechnicalBackupView({Key? key}) : super(key: key);
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

  //TextEditingController dateStart = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
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
                            'empty',
                            'uptrend',
                            'downtrend',
                            'sideways',
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
                    color: Colors.black38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fundamental',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            child: DropdownButtonFormField<String>(
                              value: controller
                                  .selectedValueParam, // Nilai dropdown yang dipilih
                              onChanged: (newValue) {
                                controller.selectedValueParam =
                                    newValue!; // Mengubah nilai dropdown yang dipilih
                              },
                              items: <String>[
                                'der',
                                'loan_to_depo_ratio',
                                'per',
                                'annualized_roe',
                                'dividen',
                                'dividen_yield',
                                'dividen_payout_ratio',
                                'pbv',
                                'annualized_per',
                                'annualized_roa',
                                'gpm',
                                'npm',
                                'eer',
                                'ear',
                                'market_cap',
                                'market_cap_asset_ratio',
                                'cfo_sales_ratio',
                                'capex_cfo_ratio',
                                'peg',
                                'harga_saham_sum_dividen',
                              ].map<DropdownMenuItem<String>>((String value) {
                                String text;
                                switch (value) {
                                  case 'der':
                                    text = "Debt to Equity Ratio";
                                    break;
                                  case 'loa':
                                    text = "Loan to Deposit Ratio";
                                    break;
                                  case 'per':
                                    text = "Price Equity Ratio";
                                    break;
                                  case 'annualized_roe':
                                    text = "annualized_roe";
                                    break;
                                  case 'dividen':
                                    text = "dividen";
                                    break;
                                  case 'dividen_yield':
                                    text = "dividen_yield";
                                    break;
                                  case 'dividen_payout_ratio':
                                    text = "dividen_payout_ratio";
                                    break;
                                  case 'pbv':
                                    text = "pbv";
                                    break;
                                  case 'annualized_per':
                                    text = "annualized_per";
                                    break;
                                  case 'annualized_roa':
                                    text = "annualized_roa";
                                    break;
                                  case 'gpm':
                                    text = "gpm";
                                    break;
                                  case 'npm':
                                    text = "npm";
                                    break;
                                  case 'eer':
                                    text = "eer";
                                    break;
                                  case 'ear':
                                    text = "ear";
                                    break;
                                  case 'market_cap':
                                    text = "market_cap";
                                    break;
                                  case 'market_cap_asset_ratio':
                                    text = "market_cap_asset_ratio";
                                    break;
                                  case 'cfo_sales_ratio':
                                    text = "cfo_sales_ratio";
                                    break;
                                  case 'capex_cfo_ratio':
                                    text = "capex_cfo_ratio";
                                    break;
                                  case 'market_cap_cfo_ratio':
                                    text = "market_cap_cfo_ratio";
                                    break;
                                  case 'peg':
                                    text = "peg";
                                    break;
                                  case 'harga_saham_sum_dividen':
                                    text = "harga_saham_sum_dividen";
                                    break;

                                  // Add cases for the other values here
                                  default:
                                    text = "Unknown"; // Handle unknown values
                                }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      text), // Teks yang akan ditampilkan pada dropdown
                                );
                              }).toList(),
                              // decoration: InputDecoration(
                              //   labelText:
                              //       'Pilih fundamental', // Label untuk dropdown
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  // Divider(
                  //   color: Colors.black38,
                  // ),
                  // Divider(
                  //   color: Colors.black38,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: DropdownButtonFormField<String>(
                              value: controller.selectedValueComparison,
                              onChanged: (newValue) {
                                controller.selectedValueComparison = newValue!;
                              },
                              items: <String>[
                                '%3C', //lessthan
                                '%3E', //morethan
                              ].map<DropdownMenuItem<String>>((String value) {
                                String text = (value == '%3C')
                                    ? "Less Than"
                                    : "More Than";
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      text), // Text to be displayed on the dropdown
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText:
                                    'Less or More', // Label for the dropdown
                              ),
                            ),
                          ),
                        ],
                      ),

                      //  SizedBox(height: 50),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: Get.width * 0.13,
                                decoration: BoxDecoration(color: secondary),
                                child: TextField(
                                  controller: controller.percentController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(fontSize: 13.0),
                                    hintStyle: TextStyle(fontSize: 11.0),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                        mainAxisAlignment: MainAxisAlignment.start,
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

                  // Container(
                  //   child: ListView.builder(
                  //       itemCount: controller
                  //           .HasilTechnical.length, // Jumlah item dalam daftar
                  //       itemBuilder: (context, index) {
                  //         final tabelTechnical =
                  //             controller.HasilTechnical[index];
                  //       }),
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ListView.builder(
                  //       itemCount: controller
                  //           .HasilTechnical.length, // Jumlah item dalam daftar
                  //       itemBuilder: (context, index) {
                  //         final tabelTechnical =
                  //             controller.HasilTechnical[index];
                  //         return Card(
                  //             color: secondary,
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(15)),
                  //             child: InkWell(
                  //                 splashColor: Colors.redAccent.withAlpha(30),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(15.0),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           Text(
                  //                               tabelTechnical['ticker']
                  //                                   .toString(),
                  //                               style: TextStyle(
                  //                                 color: Colors.black87,
                  //                                 fontSize: 10,
                  //                                 fontWeight: FontWeight.w900,
                  //                               )),
                  //                         ],
                  //                       ),
                  //                       SizedBox(
                  //                         height: 10,
                  //                       ),
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.start,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text('MA Percentage'),
                  //                               Text(
                  //                                   tabelTechnical[
                  //                                       'MAPercentage'],
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       fontSize: 10)),
                  //                             ],
                  //                           ),
                  //                           Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.start,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text('trend'),
                  //                               Text(tabelTechnical['trend'],
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       fontSize: 10)),
                  //                             ],
                  //                           ),
                  //                           Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.start,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text('change'),
                  //                               Text(tabelTechnical['change'],
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       fontSize: 10)),
                  //                             ],
                  //                           ),
                  //                           Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.start,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text('der'),
                  //                               Text(tabelTechnical['der'],
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       fontSize: 10)),
                  //                             ],
                  //                           ),
                  //                           Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.start,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text('ldr'),
                  //                               Text(tabelTechnical['ldr'],
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       fontSize: 10)),
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 )));
                  //       },
                  //     )
                  //   ],
                  // ),
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

                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
