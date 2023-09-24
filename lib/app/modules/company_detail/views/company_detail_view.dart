import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
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
import '../../../../core.dart';
import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/HistorycalData.dart';
import '../../../widgets/StockChart30.dart';
import '../../../models/JenisSaham.dart';
import '../../../models/Sekuritas.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/StockChart60.dart';
import '../../../widgets/tabel.dart';
import '../controllers/company_detail_controller.dart';

class CompanyDetailView extends GetView<CompanyDetailController> {
  CompanyDetailView({Key? key}) : super(key: key);
  CompanyDetailController controller = Get.put(CompanyDetailController());
  final ApiService apiService = ApiService();
  var status = "subscribe".obs;

  // var ticker = "AALI".obs;
  // var isSending = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          // title: Text(
          //   controller.arguments['ticker'].toString(),
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.w800,
          //     fontSize: 20,
          //   ),
          // ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent[400],
            ));
          }

          Map<String, dynamic> data = controller.company;
          Map<String, dynamic> detailFinancial = controller.HasilFinancial;
          Map<String, dynamic> detailAnalysis = controller.HasilAnalysis;
          //Widget derWidget = detailFinancial['der'] as Widget;
          //  Map<String, dynamic> namasahamtrftabel = controller.namaSahamKu;
          // Map<String, dynamic> technicalsemua = controller.semuatechnical;
          //final abc = controller.semuatechnical;

          var laporanStatus = controller.HasilLaporan['status'];
          //Map<String, dynamic> detailTabel = controller.tabel;
          List<HistoricalData> chart = controller.history;

          //final admin = controller.AdminStockApp[index];
          final formatter = NumberFormat('#,###');
          final formatter1 = NumberFormat('#,##0.00');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Card(
                    color: secondary,
                    margin: EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['result']['ticker'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent[400]),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    //detailFinancial['inputData']['aset'],
                                    data['result']['name'],
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.network(
                                  data['result']['logo'],
                                  width: 70,
                                  height: 70,
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black38,
                          ),
                          data['last_price'] != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Open",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            formatter.format(double.parse(
                                                data['last_price']['open'])),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 15))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "High",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            formatter.format(double.parse(
                                                data['last_price']['high'])),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 15))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Low",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            formatter.format(double.parse(
                                                data['last_price']['low'])),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 15))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Close",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            formatter.format(double.parse(
                                                data['last_price']['close'])),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 15))
                                      ],
                                    ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     // Text(
                                    //     //   "der",
                                    //     //   style:
                                    //     //       TextStyle(color: Colors.black38),
                                    //     // ),
                                    //     // Text(
                                    //     //   double.parse(detailTabel[
                                    //     //               'laba_bersih'])
                                    //     //           .toStringAsFixed(2) +
                                    //     //       " %",
                                    //     //   style: TextStyle(
                                    //     //       fontWeight: FontWeight.bold,
                                    //     //       fontSize: 17),
                                    //     // ),
                                    //     // Text(
                                    //     //     formatter.format(double.parse(
                                    //     //         detailTabel['outputData']
                                    //     //             ['der'])),
                                    //     //     style: TextStyle(
                                    //     //         fontWeight: FontWeight.bold,
                                    //     //         color: Colors.black87,
                                    //     //         fontSize: 15))
                                    //     // Text(detailTabel['check']['laba_bersih'],
                                    //     //     style: TextStyle(
                                    //     //         fontWeight: FontWeight.bold,
                                    //     //         color: Colors.black87,
                                    //     //         fontSize: 15))
                                    //   ],
                                    // ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "thn",
                                    //       style:
                                    //           TextStyle(color: Colors.black38),
                                    //     ),
                                    //     Text(
                                    //         detailTabel['inputData']['tahun']
                                    //             .toString(),
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.black87,
                                    //             fontSize: 15))
                                    //   ],
                                    // ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Volume",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            formatter.format(double.parse(
                                                data['last_price']['volume'])),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 15))
                                      ],
                                    ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "laba brsh",
                                    //       style:
                                    //           TextStyle(color: Colors.black38),
                                    //     ),
                                    //     Text(
                                    //         detailtabel['laba_bersih']
                                    //             .toString(),
                                    //         // formatter.format(int.parse(
                                    //         //     )),
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.black87,
                                    //             fontSize: 15))
                                    //   ],
                                    // )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          data['last_price'] != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: Get.width / 2.6,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(200, 20),
                                                // shape: StadiumBorder(),
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SekuritasModalSheet(
                                                      apiService: apiService,
                                                      trxType: 'beli',
                                                      controller: controller,
                                                      price: double.parse(
                                                          data['last_price']
                                                              ['open']));
                                                },
                                              );
                                            },
                                            child: Text("BELI"))),
                                    Container(
                                        width: Get.width / 2.6,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(200, 20),
                                                // shape: StadiumBorder(),
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SekuritasModalSheet(
                                                      apiService: apiService,
                                                      trxType: 'jual',
                                                      controller: controller,
                                                      price: double.parse(
                                                          data['last_price']
                                                              ['open']));
                                                },
                                              );
                                            },
                                            child: Text("JUAL")))
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            width: Get.width / 4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 20),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  controller.ThirtyDays(context);
                                },
                                child: Text("30 Days"))),
                        SizedBox(
                          width: 10,
                        ),
                        // Obx(() => status == 'subscribed'
                        //     ?
                        Container(
                            width: Get.width / 4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 20),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  controller.SixtyDays(context);
                                },
                                child: Text("60 Days"))),
                        // : Container()),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width / 4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 20),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  controller.NinetyDays(context);
                                },
                                child: Text("90 Days"))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width / 4,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 20),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  controller.OneHundredAndTwentyDays(context);
                                },
                                child: Text("120 Days"))),
                      ],
                    ),
                  ),

                  Container(
                    width: Get.width * 2,
                    height: Get.height * .4,
                    child: SingleChildScrollView(
                      child: StockChart30(),
                      // child: StockChart30(),

                      //child: CandleStickk(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),

                  Divider(
                    color: Colors.black38,
                  ),
                  SizedBox(height: 30),

                  // Obx(
                  //   () => status == 'Subscribed'
                  //       ?
                  // Obx(() => InkWell(
                  //       child: Container(
                  //           width: Get.width,
                  //           child: isSending.value == false &&
                  //                   controller.status == ""
                  //               ? InkWell(
                  //                   onTap: () {
                  //                     Get.toNamed(
                  //                         Routes.PAYMENT_PAGE_ADMIN_MIDTRANS);
                  //                   },
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "dwd",
                  //                         style:
                  //                             TextStyle(color: Colors.black38),
                  //                       ),
                  //                       // Text(
                  //                       //     formatter.format(double.parse(
                  //                       //         data['last_price']['volume'])),
                  //                       //     style: TextStyle(
                  //                       //         fontWeight: FontWeight.bold,
                  //                       //         color: Colors.black87,
                  //                       //         fontSize: 15))
                  //                     ],
                  //                   ),
                  //                 )
                  //               : Center(
                  //                   child: CircularProgressIndicator(),
                  //                 )),
                  //       // onTap: () {
                  //       //   Get.toNamed(Routes.PAYMENT_PAGE_ADMIN_MIDTRANS);

                  //       // },
                  //     )),

                  // Obx(
                  //   () => controller.status == 'subscribed'
                  //       ? {
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,

                  // Obx(() {
                  //   if (controller.HasilLaporan['status'] == 'subscribed') {
                  //     return Center(
                  //         child: CircularProgressIndicator(
                  //       color: Colors.redAccent[400],
                  //     ));
                  // //   }
                  // Obx(() {
                  //   if (controller.isLoading.value == true) {
                  //     return Center(
                  //         child: CircularProgressIndicator(
                  //       color: Colors.redAccent[400],
                  //     ));
                  //   }
                  //   return
                  //Obx(() => controller.HasilLaporan.value == "subscribed"
                  //Obx(() => controller.HasilLaporan.containsValue('blmsubs')

                  Obx(() {
                    if (controller.isLoading.value == true) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.redAccent[400],
                      ));
                    }
                    return Column(
                      children: [
                        Obx(() {
                          if (controller.isLoading.value == true) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.redAccent[400],
                            ));
                          }
                          return Obx(() =>
                              controller.HasilLaporan['status'] != "subscribed"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(
                                          Routes.PAYMENT_PAGE_ADMIN_MIDTRANS,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          fixedSize: Size(140, 18),
                                          backgroundColor: buttoncolor),
                                      child: Text(
                                        'Subscribe to Admin',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  : Container());
                        }),
                        Obx(() =>
                            controller.HasilLaporan['status'] == "subscribed"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Divider(
                                        color: Colors.black87,
                                      ),
                                      Divider(
                                        color: Colors.black87,
                                      ),
                                    ],
                                  )
                                : Container()),
                        Obx(() {
                          if (controller.isLoading.value == true) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.redAccent[400],
                            ));
                          }
                          return Obx(() => controller.HasilLaporan['status'] ==
                                  'subscribed'
                              ? Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Analysis",
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Get.toNamed(
                                                        Routes
                                                            .COMPANY_DETAIL_TABEL,
                                                        arguments: {
                                                          'ticker': controller
                                                                  .arguments[
                                                              'ticker'],
                                                        });
                                                  },
                                                  child: Text(
                                                    'more...',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black87,
                                      ),
                                      Column(
                                        children: [
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
                                                  SizedBox(height: 25),
                                                  Text(
                                                    "Parameter",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "DER",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Loan to Deposit Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Annualized ROE",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Dividend",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Dividend Yield",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Dividend Payout Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "PBV",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Annualized PER",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Annualized ROA",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "GPM",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "NPM",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "EER",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "EAR",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Market Cap",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Market Cap to Assets Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "CFO to Sales Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Capex to CFO Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Market Cap to CFO Ratio",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "PEG",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Harga Saham+Dividen",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                              SingleChildScrollView(
                                                controller: ScrollController(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SingleChildScrollView(
                                                      controller:
                                                          ScrollController(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            detailAnalysis[
                                                                    'tahun']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Text(
                                                      "Value",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Text(
                                                      detailFinancial['der']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial[
                                                                  'loan_to_depo_ratio']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      // detailFinancial[
                                                      //             'annualized_roe']
                                                      //         .toString() +
                                                      //     "%",
                                                      formatter1.format(double.parse(
                                                              detailFinancial[
                                                                      'annualized_roe']
                                                                  .toString())) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial['dividen']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial[
                                                                  'dividen_yield']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial[
                                                                  'dividen_payout_ratio']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial['pbv']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      // detailFinancial[
                                                      //         'annualized_per']
                                                      //     .toString(),
                                                      formatter1.format(double.parse(
                                                              detailFinancial[
                                                                      'annualized_per']
                                                                  .toString())) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter1.format(double.parse(
                                                              detailFinancial[
                                                                      'annualized_roa']
                                                                  .toString())) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial['gpm']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter1.format(
                                                              detailFinancial[
                                                                  'npm']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter1.format(
                                                              detailFinancial[
                                                                  'eer']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      detailFinancial['ear']
                                                              .toString() +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      CurrencyFormat
                                                          .convertToIdr(
                                                              detailFinancial[
                                                                  'market_cap'],
                                                              0),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      // detailFinancial[
                                                      //         'market_cap_asset_ratio']
                                                      //     .toString(),
                                                      formatter1.format(double.parse(
                                                              detailFinancial[
                                                                      'market_cap_asset_ratio']
                                                                  .toString())) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter.format(
                                                              detailFinancial[
                                                                  'cfo_sales_ratio']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter.format(
                                                              detailFinancial[
                                                                  'capex_cfo_ratio']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter.format(
                                                              detailFinancial[
                                                                  'market_cap_cfo_ratio']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      formatter.format(
                                                              detailFinancial[
                                                                  'peg']) +
                                                          "%",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "Rp." +
                                                          formatter.format(
                                                              detailFinancial[
                                                                  'harga_saham_sum_dividen']),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black38,
                                          ),
                                          SizedBox(height: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Financial",
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.black87,
                                                ),
                                              ]),
                                          Divider(
                                            color: Colors.black87,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Metric",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Aset",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Hutang Obligasi",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Simpanan",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Pinjaman",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Saldo Laba",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Ekuitas",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Jumlah Saham Beredar",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Pendapatan",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Laba Kotor",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Laba Bersih",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Harga Saham",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Operating Cashflow",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Investing Cashflow",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Total Dividen",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Stock Split",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Earnings Per Share",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  // SizedBox(height: 110),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    detailAnalysis['tahun']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Value",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis['aset'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                                'hutang_obligasi'] ??
                                                            0,
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                                'simpanan'] ??
                                                            0,
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                                'pinjaman'] ??
                                                            0,
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'saldo_laba'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'ekuitas'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    formatter.format(
                                                        detailAnalysis[
                                                            'jml_saham_edar']),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'pendapatan'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'laba_kotor'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'laba_bersih'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'harga_saham'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    CurrencyFormat.convertToIdr(
                                                        detailAnalysis[
                                                            'operating_cash_flow'],
                                                        0),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Rp." +
                                                        formatter.format(
                                                            detailAnalysis[
                                                                'investing_cash_flow']),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    formatter.format(
                                                        detailAnalysis[
                                                            'total_dividen']),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    detailAnalysis[
                                                            'stock_split']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Rp." +
                                                        detailAnalysis['eps']
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container());
                        }),
                      ],
                    );
                  }),

                  // Obx(() {
                  //   if (controller.isLoading.value == true) {
                  //     return Center(
                  //         child: CircularProgressIndicator(
                  //       color: Colors.redAccent[400],
                  //     ));
                  //   } else

                  // }),

                  //  )
                  //       : SizedBox(),
                  // ),

                  // Container(
                  //   width: Get.width * 2,
                  //   height: Get.height * .4,
                  //   child: SingleChildScrollView(
                  //     child: tabel(),
                  //     //child: CandleStickk(),
                  //     scrollDirection: Axis.horizontal,
                  //   ),
                  // )

                  // }),

                  //  )
                  //       : SizedBox(),
                  // ),

                  // Container(
                  //   width: Get.width * 2,
                  //   height: Get.height * .4,
                  //   child: SingleChildScrollView(
                  //     child: tabel(),
                  //     //child: CandleStickk(),
                  //     scrollDirection: Axis.horizontal,
                  //   ),
                  // )
                ],
              ),
            ),
          );
        }));
  }
}

class SekuritasModalSheet extends StatelessWidget {
  final ApiService apiService;
  final String trxType;
  final CompanyDetailController controller;
  final double price;
  const SekuritasModalSheet(
      {required this.apiService,
      required this.trxType,
      required this.controller,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sekuritas>>(
      future: apiService.fetchSekuritas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Sekuritas> sekuritas = snapshot.data!;

          return ListView.builder(
            // backgroundColor: buttoncolor,
            itemCount: sekuritas.length,
            itemBuilder: (context, index) {
              final sekuritasItem = sekuritas[index];
              return Padding(
                //backgroundColor: primary,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    color: primary,
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.idSekuritas = sekuritasItem.id;
                        controller.feeBeli.value = sekuritasItem.feeBeli;
                        Navigator.pop(context);
                        controller.showDialog(
                            price,
                            trxType,
                            sekuritasItem.feeBeli,
                            sekuritasItem.feeJual,
                            sekuritasItem.namaSekuritas,
                            sekuritasItem.id,
                            context);
                      },
                      child: ColoredBox(
                        color: primary,
                        child: Column(
                            //  color: secondary,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sekuritasItem.namaSekuritas,
                                  style: TextStyle(
                                      color: Colors.redAccent[400],
                                      // backgroundColor: primary,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Fee Beli : "),
                                      Text(
                                        '${sekuritasItem.feeBeli}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          //  backgroundColor: primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text("Fee Jual : "),
                                      Text(
                                        '${sekuritasItem.feeJual}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          //  backgroundColor: primary,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.black26,
                              )
                            ]),
                      ),
                    )),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching data'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
