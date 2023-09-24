import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../models/HistorycalData.dart';
import 'package:fl_chart/fl_chart.dart';

import '../modules/company_detail/controllers/company_detail_controller.dart';
import '../modules/dashboard/controllers/detail_technical_controller.dart';

class DetailTechnical extends StatelessWidget {
  CompanyDetailController controller = Get.put(CompanyDetailController());
  final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5,
      child: Obx(
        () => controller.DetailTechnical.length > 0
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),

                    // titlesData: FlTitlesData(show: true),
                    // lineTouchData: LineTouchData(enabled: true),
                    lineBarsData: [
                      // The red line
                      // LineChartBarData(
                      //   spots: getChartData(),
                      //   isCurved: true,
                      //   barWidth: 3,
                      //   colors: [Colors.green],
                      //   // color: Colors.red,
                      // ),
                      // The orange line
                      LineChartBarData(
                        spots: getChartDataLow(),
                        isCurved: false,
                        barWidth: 3,
                        colors: [Colors.redAccent],
                        // isStrokeCapRound: false,
                        dotData: FlDotData(show: false),
                        // legend: Legend(isVisible: true)

                        //  color: Colors.orange,
                      ),
                      // The blue line
                      LineChartBarData(
                        spots: getChartDataHigh(),
                        isCurved: false,
                        barWidth: 3,
                        colors: [Colors.greenAccent],
                        dotData: FlDotData(show: false),
                      ),
                      LineChartBarData(
                        spots: getChartDataOpen(),
                        isCurved: false,
                        barWidth: 3,
                        colors: [Colors.blueAccent],
                        dotData: FlDotData(show: false),
                      ),
                      LineChartBarData(
                        spots: getChartDataClose(),
                        isCurved: false,
                        barWidth: 3,
                        colors: [Colors.yellowAccent],
                        dotData: FlDotData(show: false),
                        //belowBarData: BarAreaData(show: true)
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: true,
                        //Legend: true,
                        rotateAngle: 0,
                        interval: 3,
                        getTextStyles: (context, value) =>
                            TextStyle(fontSize: 10),
                        getTitles: (value) {
                          int index = value.toInt();
                          if (index >= 0 &&
                              index < controller.DetailTechnical.length) {
                            final date = DateTime.parse(
                                controller.DetailTechnical[index].date);
                            return dateFormatter.format(date);
                          }
                          return '';
                        },
                      ),
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
                                10), // Adjust the margin between the chart and the right titles
                        // ... (other right title configurations)
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  double getMinVolume() {
    double minVolume = double.infinity;
    for (var data in controller.DetailTechnical) {
      if (data.volume < minVolume) {
        minVolume = data.volume.toDouble();
      }
    }
    return minVolume;
  }

  double getMaxVolume() {
    double maxVolume = 0;
    for (var data in controller.DetailTechnical) {
      if (data.volume > maxVolume) {
        maxVolume = data.volume.toDouble();
      }
    }
    return maxVolume;
  }

  List<FlSpot> getChartData() {
    List<FlSpot> chartData = [];
    for (int i = 0; i < controller.DetailTechnical.length; i++) {
      chartData.add(FlSpot(
          i.toDouble(), controller.DetailTechnical[i].volume.toDouble()));
    }
    print("ini chart data");
    print(chartData);
    return chartData;
  }

  List<FlSpot> getChartDataLow() {
    List<FlSpot> chartData2 = [];
    for (int i = 0; i < controller.DetailTechnical.length; i++) {
      chartData2.add(
          FlSpot(i.toDouble(), controller.DetailTechnical[i].low.toDouble()));
    }
    print("ini chart2 data");
    print(chartData2);
    return chartData2;
  }

  List<FlSpot> getChartDataHigh() {
    List<FlSpot> chartData3 = [];
    for (int i = 0; i < controller.DetailTechnical.length; i++) {
      chartData3.add(
          FlSpot(i.toDouble(), controller.DetailTechnical[i].high.toDouble()));
    }
    return chartData3;
  }

  List<FlSpot> getChartDataOpen() {
    List<FlSpot> chartData4 = [];
    for (int i = 0; i < controller.DetailTechnical.length; i++) {
      chartData4.add(
          FlSpot(i.toDouble(), controller.DetailTechnical[i].open.toDouble()));
    }
    print("ini chart2 data");
    print(chartData4);
    return chartData4;
  }

  List<FlSpot> getChartDataClose() {
    List<FlSpot> chartData5 = [];
    for (int i = 0; i < controller.DetailTechnical.length; i++) {
      chartData5.add(
          FlSpot(i.toDouble(), controller.DetailTechnical[i].close.toDouble()));
    }
    return chartData5;
  }
}
