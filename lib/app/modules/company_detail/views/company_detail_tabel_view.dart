import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/models/TabelValuation.dart';
import 'package:stock_app/app/widgets/CandleStick.dart';
import 'package:stock_app/app/widgets/DetailPerformance.dart';
import 'package:stock_app/app/widgets/DetailValuation.dart';

import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/HistorycalData.dart';
import '../../../widgets/DetailDividend.dart';
import '../../../widgets/DetailTechnical.dart';
import '../../../widgets/StockChart30.dart';
import '../../../models/JenisSaham.dart';
import '../../../models/Sekuritas.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart60.dart';
import '../../../widgets/tabel.dart';
import '../controllers/company_detail_controller.dart';
import '../controllers/company_detail_tabel_controller.dart';

class CompanyDetailTabelView extends GetView<CompanyDetailTabelController> {
  CompanyDetailTabelView({Key? key}) : super(key: key);
  CompanyDetailTabelController controller =
      Get.put(CompanyDetailTabelController());
  final ApiService apiService = ApiService();
  var status = "subscribe".obs;

  Future<void> onRefresh() async {
    // Perform any actions you want on refreshing the page.
    // For example, you can update data or reload the page content.
    // await controller
    //     .fetchBeli(); // Replace this with your actual data-fetching logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          controller.arguments['ticker'].toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // onRefresh: onRefresh,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Column(
          children: [
            Column(
              children: [
                Obx(
                  () {
                    if (controller.isLoading.value == true) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.redAccent[400],
                      ));
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 30),
                                      Text(
                                        "Analysis",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Column(
                                        children: [
                                          Text("Tahun"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("DER"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Loan to Deposit Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Annualized ROE"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Dividend"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Dividend Yield"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Dividen Payout Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("PBV"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Annualized PER"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Annualized ROA"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("GPM"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("NPM"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("EER"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("EAR"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Market Cap"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Market Cap to Assets Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("CFO to Sales Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Capex to CFO Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Market Cap to CFO Ratio"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("PEG"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Harga Saham+Dividen"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 30),
                                      Text(
                                        "Financial",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Aset"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Hutang Obligasi"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Simpanan"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Pinjaman"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Saldo Laba"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Ekuitas"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Jumlah Saham Beredar"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Pendapatan"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Laba Kotor"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Laba Bersih"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Harga Saham"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Operating Cashflow"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Investing Cashflow"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Total Dividend"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Stock Split"),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        children: [
                                          Text("Earning Per Share"),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: controller.hasil.map((company) {
                                final formatter = NumberFormat('#,###');
                                return Card(
                                  color: secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(height: 80),
                                            Text(company[1]['tahun'].toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['der']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0][
                                                        'loan_to_depo_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0]
                                                        ['annualized_roe']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                company[0]['dividen']
                                                        .toString() +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0]
                                                        ['dividen_yield']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0][
                                                        'dividen_payout_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                company[0]['pbv'].toString() +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                company[0]['annualized_per']
                                                        .toString() +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                company[0]['annualized_roa']
                                                        .toString() +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['gpm']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['npm']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['eer']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['ear']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[0]['market_cap'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0][
                                                        'market_cap_asset_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0]
                                                        ['cfo_sales_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0]
                                                        ['capex_cfo_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[0][
                                                        'market_cap_cfo_ratio']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                        company[0]['peg']) +
                                                    "%",
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                "Rp." +
                                                    formatter.format(company[0][
                                                        'harga_saham_sum_dividen']),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 95),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['aset'], 0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1][
                                                            'hutang_obligasi'] ??
                                                        0,
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['simpanan'] ?? 0,
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['pinjaman'] ?? 0,
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['saldo_laba'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['ekuitas'], 0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[1]
                                                    ['jml_saham_edar']),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['pendapatan'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['laba_kotor'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['laba_bersih'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]['harga_saham'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]
                                                        ['operating_cash_flow'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                CurrencyFormat.convertToIdr(
                                                    company[1]
                                                        ['investing_cash_flow'],
                                                    0),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(company[1]
                                                    ['total_dividen']),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text(
                                                formatter.format(
                                                    company[1]['stock_split']),
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Text("Rp." + company[1]['eps'],
                                                style: TextStyle()),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Obx(() {
              if (controller.isLoading.value == true) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.redAccent[400],
                ));
              }
              return Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Valuation(%)"),
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    children: [
                      SingleChildScrollView(
                        //scrollDirection: Axis.horizontal,
                        // controller: ScrollController(),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.97,
                                  height: 210,
                                  child: SingleChildScrollView(
                                    child: DetailValuation(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Card(
                                    color: secondary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 0.3,
                                    // width: Get.width * 2,
                                    // height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        children: [
                                          Column(children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '__',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .greenAccent),
                                                            ),
                                                            Text(
                                                              '',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .greenAccent),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'PVB',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '__',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .redAccent),
                                                            ),
                                                            Text(
                                                              '',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .redAccent),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'EER',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '__',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blueAccent),
                                                            ),
                                                            Text(
                                                              '',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blueAccent),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'EAR',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '__',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .yellowAccent),
                                                            ),
                                                            Text(
                                                              '',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .yellowAccent),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'PER',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ],
                                      ),
                                      //child: StockChart30(),

                                      //child: CandleStickk(),
                                      // scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Performance(%)"),
              ],
            ),
            SizedBox(height: 15),
            Column(
              children: [
                SingleChildScrollView(
                  //scrollDirection: Axis.horizontal,
                  // controller: ScrollController(),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * 0.97,
                            height: 210,
                            child: SingleChildScrollView(
                              child: DetailPerformance(),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Card(
                              color: secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 0.3,
                              // width: Get.width * 2,
                              // height: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .greenAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .greenAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'GPM',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'ROE',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'ROA',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .yellowAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .yellowAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'NPM',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ],
                                ),
                                //child: StockChart30(),

                                //child: CandleStickk(),
                                // scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dividend(%)"),
              ],
            ),
            SizedBox(height: 15),
            Column(
              children: [
                SingleChildScrollView(
                  //scrollDirection: Axis.horizontal,
                  // controller: ScrollController(),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * 0.97,
                            height: 210,
                            child: SingleChildScrollView(
                              child: DetailDividend(),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Card(
                              color: secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 0.3,
                              // width: Get.width * 2,
                              // height: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .greenAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .greenAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Dividend Yield',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '__',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Dividend Payout Ratio',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ],
                                ),
                                //child: StockChart30(),

                                //child: CandleStickk(),
                                // scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
