import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../models/HistorycalData.dart';
import 'package:fl_chart/fl_chart.dart';

import '../modules/company_detail/controllers/company_detail_controller.dart';
import '../modules/company_detail/controllers/company_detail_tabel_controller.dart';
import '../modules/dashboard/controllers/detail_technical_controller.dart';

class DetailValuation extends StatelessWidget {
  CompanyDetailTabelController controller =
      Get.put(CompanyDetailTabelController());
  final DateFormat dateFormatter = DateFormat('yyyy');
  var isLoading = false.obs;
  var isSending = false.obs;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Obx(() {
        if (controller.isLoading.value == true) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.redAccent[400],
          ));
        }
        return Obx(
          () => controller.DetailValuation.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getChartDataPBV(),
                          isCurved: false,
                          barWidth: 3,
                          colors: [Colors.greenAccent],
                          dotData: FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: getChartDataEER(),
                          isCurved: false,
                          barWidth: 3,
                          colors: [Colors.redAccent],
                          dotData: FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: getChartDataEAR(),
                          isCurved: false,
                          barWidth: 3,
                          colors: [Colors.blueAccent],
                          dotData: FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: getChartDataPER(),
                          isCurved: false,
                          barWidth: 3,
                          colors: [Colors.yellowAccent],
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                            showTitles: true,
                            //Legend: true,
                            rotateAngle: 0,
                            interval: 1,
                            getTextStyles: (context, value) =>
                                TextStyle(fontSize: 10),
                            getTitles: (value) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < controller.Tahun.length) {
                                // final tahunn = DateTime.parse(
                                //     controller.Tahun[index].tahun!);
                                final tahunn1 = controller.Tahun[index].tahun!;
                                print("tahun tabel");
                                // print(tahunn);
                                // return dateFormatter.format(tahunn);
                                return tahunn1;
                              }
                              return "";
                            }

                            //     //         List<String> dates = ['2023-08-01', '2023-08-02', '2023-08-03', '2023-08-04', '2023-08-05', '2023-08-06'];
                            //     // if (value >= 0 && value < dates.length) {
                            //     //   return dates[value.toInt()];
                            //     // }
                            //     // return '';
                            //   },
                            ),

                        // bottomTitles: SideTitles(showTitles: false),
                        rightTitles: SideTitles(showTitles: false),
                        topTitles: SideTitles(
                          showTitles: false,
                          margin: 20,
                          reservedSize: 40,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          reservedSize:
                              40, // Adjust the space for the right titles
                          margin: 20,
                          getTextStyles: (context, value) => TextStyle(
                              fontSize:
                                  12), // Adjust the margin between the chart and the right titles
                          // ... (other right title configurations)
                        ),
                      ),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }

  // double getMinVolume() {
  //   double minYear = double.infinity;
  //   for (var data in controller.DetailValuation) {
  //     if (data.tahun < minYear) {
  //       minYear = data.tahun.toDouble();
  //     }
  //   }
  //   return minYear;
  // }

  // double getMaxVolume() {
  //   double maxYear = 0;
  //   for (var data in controller.DetailValuation) {
  //     if (data.tahun > maxYear) {
  //       maxYear = data.tahun.toDouble();
  //     }
  //   }
  //   return maxYear;
  // }

  // double EER() {
  //   double minEER = double.infinity;
  //   for (var data in controller.DetailValuation) {
  //     if (data.eer < minEER) {
  //       minEER = data.eer.toDouble()?;
  //     }
  //   }
  //   return minEER;
  // }

  List<FlSpot> getChartDataEER() {
    List<FlSpot> chartData = [];
    for (int i = 0; i < controller.DetailValuation.length; i++) {
      chartData.add(FlSpot(
          i.toDouble(), controller.DetailValuation[i].eer?.toDouble() ?? 0));
    }
    print("ini chart data");
    print(chartData);
    return chartData;
  }

  // List<FlSpot> tahun() {
  //   List<FlSpot> chartData = [];
  //   for (int i = 0; i < controller.Tahun.length; i++) {
  //     chartData.add(
  //         FlSpot(i.toDouble(), controller.Tahun[i].tahun?.toDouble() ?? 0));
  //   }
  //   print("ini tahun");
  //   print(chartData);
  //   return chartData;
  // }

  List<FlSpot> getChartDataEAR() {
    List<FlSpot> chartDataEAR = [];
    for (int i = 0; i < controller.DetailValuation.length; i++) {
      chartDataEAR.add(FlSpot(
          i.toDouble(), controller.DetailValuation[i].ear?.toDouble() ?? 0.0));
    }
    print("ini chart data");
    print(chartDataEAR);
    return chartDataEAR;
  }

  List<FlSpot> getChartDataPER() {
    List<FlSpot> chartDataPER = [];
    for (int i = 0; i < controller.DetailValuation.length; i++) {
      chartDataPER.add(FlSpot(i.toDouble(),
          controller.DetailValuation[i].annualizedPer?.toDouble() ?? 0.0));
    }
    print("ini chart data");
    print(chartDataPER);
    return chartDataPER;
  }

  List<FlSpot> getChartDataPBV() {
    List<FlSpot> chartDataPBV = [];
    for (int i = 0; i < controller.DetailValuation.length; i++) {
      chartDataPBV.add(FlSpot(
          i.toDouble(), controller.DetailValuation[i].pbv?.toDouble() ?? 0.0));
    }
    print("ini chart datadede");
    print(chartDataPBV);
    return chartDataPBV;
  }

  // List<FlSpot> getChartDataLow() {
  //   List<FlSpot> chartData2 = [];
  //   for (int i = 0; i < controller.DetailValuation.length; i++) {
  //     chartData2.add(
  //         FlSpot(i.toDouble(), controller.DetailValuation[i].low.toDouble()));
  //   }
  //   print("ini chart2 data");
  //   print(chartData2);
  //   return chartData2;
  // }

  // List<FlSpot> getChartDataHigh() {
  //   List<FlSpot> chartData3 = [];
  //   for (int i = 0; i < controller.DetailValuation.length; i++) {
  //     chartData3.add(
  //         FlSpot(i.toDouble(), controller.DetailValuation[i].high.toDouble()));
  //   }
  //   return chartData3;
  // }

  // List<FlSpot> getChartDataOpen() {
  //   List<FlSpot> chartData4 = [];
  //   for (int i = 0; i < controller.DetailValuation.length; i++) {
  //     chartData4.add(
  //         FlSpot(i.toDouble(), controller.DetailValuation[i].open.toDouble()));
  //   }
  //   print("ini chart2 data");
  //   print(chartData4);
  //   return chartData4;
  // }

  // List<FlSpot> getChartDataClose() {
  //   List<FlSpot> chartData5 = [];
  //   for (int i = 0; i < controller.DetailValuation.length; i++) {
  //     chartData5.add(
  //         FlSpot(i.toDouble(), controller.DetailValuation[i].close.toDouble()));
  //   }
  //   return chartData5;
  // }
}
