// import 'package:flutter/material.dart';
// import 'package:flutter_candlesticks/flutter_candlesticks.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:intl/intl.dart';
// import '../models/HistorycalData.dart';
// import 'package:fl_chart/fl_chart.dart';

// import '../modules/company_detail/controllers/company_detail_controller.dart';
// import '../modules/listing/controllers/listing_controller.dart';

// class StockChartMini extends StatelessWidget {
//   ListingController controller = Get.put(ListingController());
//   final DateFormat dateFormatter = DateFormat('dd MMM yyyy');

//   List sampleData = [
//     {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
//     {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
//     {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
//     {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
//     {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
//     {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
//     {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
//     {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
//     {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
//     {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
//     {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
//     {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
//     {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
//     {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
//     {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
//   ];
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Container(
//   //     child: new OHLCVGraph(
//   //         data: sampleData, enableGridLines: false, volumeProp: 0.2),
//   //     // return AspectRatio(
//   //     //   aspectRatio: .8,
//   //     //   OHLCVGraph(
//   //     //             data: sampleData, enableGridLines: false, volumeProp: 0.2)
//   //     //         : Center(child: CircularProgressIndicator()),
//   //     //   ),
//   //   );
//   // }

//   double getMinVolume() {
//     double minVolume = double.infinity;
//     for (var data in controller.historicalData) {
//       if (data.volume < minVolume) {
//         minVolume = data.volume.toDouble();
//       }
//     }
//     return minVolume;
//   }

//   double getMaxVolume() {
//     double maxVolume = 0;
//     for (var data in controller.historicalData) {
//       if (data.volume > maxVolume) {
//         maxVolume = data.volume.toDouble();
//       }
//     }
//     return maxVolume;
//   }

//   List<FlSpot> getChartData() {
//     List<FlSpot> chartData = [];
//     for (int i = 0; i < controller.historicalData.length; i++) {
//       chartData.add(
//           FlSpot(i.toDouble(), controller.historicalData[i].volume.toDouble()));
//     }
//     return chartData;
//   }
// }
