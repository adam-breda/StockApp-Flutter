import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../models/HistorycalData.dart';
import 'package:fl_chart/fl_chart.dart';

import '../modules/company_detail/controllers/company_detail_controller.dart';

class StockChart90 extends StatelessWidget {
  CompanyDetailController controller = Get.put(CompanyDetailController());
  final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Obx(
        () => controller.historicalData90.length > 0
            ? LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    show: false, // Hide the border
                  ),
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  minX: 0,
                  maxX: controller.historicalData90.length.toDouble() - 1,
                  minY: getMinVolume(),
                  maxY: getMaxVolume(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: getChartData(),
                      isCurved: true,
                      colors: [Colors.redAccent],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      rotateAngle: 0,
                      interval: 10,
                      getTextStyles: (context, value) =>
                          TextStyle(fontSize: 10),
                      getTitles: (value) {
                        int index = value.toInt();
                        if (index >= 0 &&
                            index < controller.historicalData90.length) {
                          final date = DateTime.parse(
                              controller.historicalData90[index].date);
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
                      reservedSize: 40, // Adjust the space for the right titles
                      margin: 20,
                      getTextStyles: (context, value) => TextStyle(
                          fontSize:
                              10), // Adjust the margin between the chart and the right titles
                      // ... (other right title configurations)
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
    for (var data in controller.historicalData90) {
      if (data.volume < minVolume) {
        minVolume = data.volume.toDouble();
      }
    }
    return minVolume;
  }

  double getMaxVolume() {
    double maxVolume = 0;
    for (var data in controller.historicalData90) {
      if (data.volume > maxVolume) {
        maxVolume = data.volume.toDouble();
      }
    }
    return maxVolume;
  }

  List<FlSpot> getChartData() {
    List<FlSpot> chartData = [];
    for (int i = 0; i < controller.historicalData90.length; i++) {
      chartData.add(FlSpot(
          i.toDouble(), controller.historicalData90[i].volume.toDouble()));
    }
    return chartData;
  }
}
