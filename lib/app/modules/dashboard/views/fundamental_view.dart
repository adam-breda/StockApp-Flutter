import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/app/modules/dashboard/controllers/technical_controller.dart';
import 'package:stock_app/app/modules/dashboard/views/technical_view.dart';
import 'package:stock_app/app/routes/app_pages.dart';

import '../../../Values/values.dart';
import '../../../models/JenisTechnical/JenisTrend.dart';
import '../../../widgets/Technical.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FundamentalView extends GetView<TechnicalController> {
  TechnicalController controller = Get.put(TechnicalController());

  ValueNotifier<String> trendController = ValueNotifier<String>('');
  TextEditingController dropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<FundamentalViewState>(
        init: FundamentalViewState(),
        builder: (state) {
          return RefreshIndicator(
            onRefresh: state.onRefresh,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: primary,
              appBar: AppBar(
                title: Text(
                  "Fundamental",
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: ListView(
                children: [
                  SingleChildScrollView(
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
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          String text;
                                          switch (value) {
                                            case 'der':
                                              text = "Debt to Equity Ratio";
                                              break;
                                            case 'loan_to_depo_ratio':
                                              text = "Loan to Deposit Ratio";
                                              break;
                                            case 'per':
                                              text = "Price Equity Ratio";
                                              break;
                                            case 'annualized_roe':
                                              text = "Annualized ROE";
                                              break;
                                            case 'dividen':
                                              text = "Dividen";
                                              break;
                                            case 'dividen_yield':
                                              text = "Dividen Yield";
                                              break;
                                            case 'dividen_payout_ratio':
                                              text = "Dividen Payout Ratio";
                                              break;
                                            case 'pbv':
                                              text = "PBV";
                                              break;
                                            case 'annualized_per':
                                              text = "Annualized PER";
                                              break;
                                            case 'annualized_roa':
                                              text = "Annualized ROA";
                                              break;
                                            case 'gpm':
                                              text = "GPM";
                                              break;
                                            case 'npm':
                                              text = "NPM";
                                              break;
                                            case 'eer':
                                              text = "EER";
                                              break;
                                            case 'ear':
                                              text = "EAR";
                                              break;
                                            case 'market_cap':
                                              text = "Market Cap";
                                              break;
                                            case 'market_cap_asset_ratio':
                                              text = "Market Cap Asset Ratio";
                                              break;
                                            case 'cfo_sales_ratio':
                                              text = "CFO Sales Ratio";
                                              break;
                                            case 'capex_cfo_ratio':
                                              text = "Capex CFO Ratio";
                                              break;
                                            case 'market_cap_cfo_ratio':
                                              text = "Market Cap CFO Ratio";
                                              break;
                                            case 'peg':
                                              text = "PEG";
                                              break;
                                            case 'harga_saham_sum_dividen':
                                              text = "Harga Saham + Dividen";
                                              break;
                                            default:
                                              text =
                                                  "Unknown"; // Handle unknown values
                                          }
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                                text), // Teks yang akan ditampilkan pada dropdown
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                        value:
                                            controller.selectedValueComparison,
                                        onChanged: (newValue) {
                                          controller.selectedValueComparison =
                                              newValue!;
                                        },
                                        items: <String>[
                                          '%3C', //lessthan
                                          '%3E', //morethan
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
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
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: Get.width * 0.13,
                                          decoration:
                                              BoxDecoration(color: secondary),
                                          child: TextField(
                                            controller:
                                                controller.percentController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(fontSize: 13.0),
                                              hintStyle:
                                                  TextStyle(fontSize: 11.0),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // String inputText =
                                //     '${controller.selectedValueParam},'
                                //     '${controller.selectedValueComparison},'
                                //     '${controller.percentController.text}';

                                String? selectedParam =
                                    controller.selectedValueParam;
                                String? selectedComparison =
                                    controller.selectedValueComparison;
                                String? percent =
                                    controller.percentController.text;

                                String selectedParamText =
                                    getDropdownItemText(selectedParam!);
                                String selectedComparisonText =
                                    getComparisonItemText(selectedComparison!);

                                //print("Selected Parameter: $selectedParamText");
                                // print(
                                //     "Selected Comparison: $selectedComparisonText");
                                // print("Percent Value: $percent");

                                print("Selected Parameter: $selectedParam");
                                print(
                                    "Selected Comparison: $selectedComparison");
                                print("Percent Value: $percent");

                                String valueTampil =
                                    '$selectedParamText   $selectedComparisonText   $percent %';

                                String valueKirim =
                                    '$selectedParam,$selectedComparison,$percent';
                                print(valueKirim);

                                state.addInputHistory(valueKirim);
                                state.addTampil(valueTampil);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  fixedSize: Size(350, 20),
                                  backgroundColor: buttoncolor),
                              child: Text('Add Parameter'),
                            ),
                            // SizedBox(height: 16.0),
                            // // for (int index = 0;
                            // //     index < state.inputHistory.length;
                            // //     index++)

                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: state.inputHistory.length,
                            //   itemBuilder: (context, index) {
                            //     return Dismissible(
                            //       key: Key(state.inputHistory[index]),
                            //       onDismissed: (direction) {
                            //         state.removeInputHistory(index);
                            //       },
                            //       background: Container(
                            //         color: Colors.red,
                            //         child:
                            //             Icon(Icons.delete, color: Colors.white),
                            //         alignment: Alignment.centerRight,
                            //         padding: EdgeInsets.only(right: 16.0),
                            //       ),
                            //       child: Card(
                            //         color: secondary,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(15)),
                            //         elevation: 1,
                            //         margin: EdgeInsets.symmetric(
                            //             vertical: 4, horizontal: 8),
                            //         child: ListTile(
                            //           title: Text(
                            //             state.inputHistory[index],
                            //             style: TextStyle(fontSize: 16),
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            SizedBox(height: 25.0),
                            // for (int index = 0;
                            //     index < state.inputHistory.length;
                            //     index++)

                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.Tampil.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: Key(state.Tampil[index]),
                                  onDismissed: (direction) {
                                    state.removeTampil(index);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 16.0),
                                  ),
                                  child: Card(
                                    color: secondary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 1,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: ListTile(
                                      title: Text(
                                        state.Tampil[index],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  String? fundamental = controller.selectedValueParam;
                  String? comparison = controller.selectedValueComparison;
                  String percent = controller.percentController.text;

                  // Update nilai input pada state
                  state.updateInputValues(fundamental!, comparison!, percent);
                  // state.updateTampilValues(fundamental!, comparison!, percent);

                  // Pindah ke TechnicalView dengan mengirim nilai input sebagai argumen
                  await Get.to<TechnicalView>(() => TechnicalView(
                        inputHistory: state.inputHistory,
                        Tampil: state.Tampil,
                        percentValue: percent,
                        selectedComparison: comparison,
                        selectedFundamental: fundamental,
                      ));
                  print(state.inputHistory);
                },
                label: const Text('Save'),
                icon: const Icon(Icons.send),
                backgroundColor: Colors.brown,
              ),
            ),
          );
        });
  }

  String getDropdownItemText(String selectedParam) {
    switch (selectedParam) {
      case 'der':
        return "Debt to Equity Ratio";
      case 'loan_to_depo_ratio':
        return "Loan to Deposit Ratio";
      case 'per':
        return "Price Equity Ratio";
      case 'annualized_roe':
        return "Annualized ROE";
      case 'dividen':
        return "Dividen";
      case 'dividen_yield':
        return "Dividen Yield";
      case 'dividen_payout_ratio':
        return "Dividen Payout Ratio";
      case 'pbv':
        return "PBV";
      case 'annualized_per':
        return "Annualized PER";
      case 'annualized_roa':
        return "Annualized ROA";
      case 'gpm':
        return "GPM";
      case 'npm':
        return "NPM";
      case 'eer':
        return "EER";
      case 'ear':
        return "EAR";
      case 'market_cap':
        return "Market Cap";
      case 'market_cap_asset_ratio':
        return "Market Cap Asset Ratio";
      case 'cfo_sales_ratio':
        return "CFO Sales Ratio";
      case 'capex_cfo_ratio':
        return "Capex CFO Ratio";
      case 'market_cap_cfo_ratio':
        return "Market Cap CFO Ratio";
      case 'peg':
        return "PEG";
      case 'harga_saham_sum_dividen':
        return "Harga Saham + Dividen";
      default:
        return "Unknown"; // Handle unknown values
    }
  }

  String getComparisonItemText(String value) {
    switch (value) {
      case '%3C':
        return "<";
      case '%3E':
        return ">";
      default:
        return "Unknown";
    }
  }
}

class FundamentalViewState extends GetxController {
  List<String> inputHistory = [];
  List<String> Tampil = [];

  String selectedFundamental = '';
  String selectedComparison = '';
  String percentValue = '';

  Future<void> onRefresh() async {
    inputHistory = [];
    Tampil = [];
  }

  void updateInputValues(
      String fundamental, String comparison, String percent) {
    selectedFundamental = fundamental;
    selectedComparison = comparison;
    percentValue = percent;
    update(); // Rebuild the widget
  }

  void addInputHistory(String input) {
    inputHistory.add(input);
    //Tampil.add(input);

    print("dwd");
    print(inputHistory);
    update(); // Rebuild the widget
  }

  void removeInputHistory(int index) {
    inputHistory.removeAt(index);
    update(); // Rebuild the widget
  }

  void updateTampilValues(
      String fundamental, String comparison, String percent) {
    selectedFundamental = fundamental;
    selectedComparison = comparison;
    percentValue = percent;
    update(); // Rebuild the widget
  }

  void addTampil(String input) {
    Tampil.add(input);
    //ViewFundamental.add(input);
    print("dwd");
    print(Tampil);
    update(); // Rebuild the widget
  }

  void removeTampil(int index) {
    Tampil.removeAt(index);
    update(); // Rebuild the widget
  }
}
