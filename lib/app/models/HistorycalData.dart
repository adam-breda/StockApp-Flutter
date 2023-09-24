import 'dart:convert';

class HistoricalData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  HistoricalData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory HistoricalData.fromJson(Map<String, dynamic> json) {
    return HistoricalData(
      date: json['date'],
      open: double.parse(json['open']),
      high: double.parse(json['high']),
      low: double.parse(json['low']),
      close: double.parse(json['close']),
      volume: json['volume'],
    );
  }
}

// List<HistoricalData> parseHistoricalData(String jsonString) {
//   final parsed = jsonDecode(jsonString);
//   final results = parsed['data']['results'];

//   return List<HistoricalData>.from(
//       results..map((e) => HistoricalData.fromJson(e)).toList().reversed.toList()
//       // map((json) => HistoricalData.fromJson(json)),
//       );
// }
