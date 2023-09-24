import 'dart:convert';
import 'dart:ffi';

class TabelValuation {
  final int? pbv;
  final int? per;
  final int? eer;
  final int? der;
  final int? annualizedRoe;
  final int? annualizedRoa;
  final int? annualizedPer;
  final int? gpm;
  final int? npm;
  final int? ear;
  final int? dividenYield;
  final int? dividenPayoutRatio;
  final String? tahun;
  final int? marketCap;
  final int? type;
  final int? id_jenis_fundamental;
  //final int? tahun;
  //final int loan_to_depo_ratio;
  // final int tahun;

  TabelValuation({
    this.pbv,
    this.per,
    this.der,
    this.eer,
    this.annualizedRoe,
    this.annualizedRoa,
    this.annualizedPer,
    this.gpm,
    this.npm,
    this.ear,
    this.dividenYield,
    this.dividenPayoutRatio,
    this.tahun,
    this.marketCap,
    this.type,
    this.id_jenis_fundamental,
    // required this.tahun,
    // required this.loan_to_depo_ratio,
    // required this.tahun,
  });

  factory TabelValuation.fromJson(Map<String, dynamic> json) {
    return TabelValuation(
      // der: json['der'],
      // annualizedRoe: json['annualized_roe'],
      // gpm: json['gpm'],
      // npm: json['npm'],
      // ear: json['ear'],
      // marketCap: json['market_cap'],
      pbv: json['pbv'] as int?,
      //pbv: double.parse(json['pbv']),
      der: json['der'] as int?,
      eer: json['eer'] as int?,
      per: json['per'] as int?,
      annualizedRoe: json['annualized_roe'] as int?,
      annualizedRoa: json['annualized_roa'] as int?,
      annualizedPer: json['annualized_epr'] as int?,
      gpm: json['gpm'] as int?,
      npm: json['npm'] as int?,
      ear: json['ear'] as int?,
      dividenYield: json['dividen_yield'] as int?,
      dividenPayoutRatio: json['dividen_payout_ratio'] as int?,
      tahun: json['tahun'],
      marketCap: json['market_cap'] as int?,
      type: json['type'] as int? ?? 0,
      id_jenis_fundamental: json['id_jenis_fundamental'] as int? ?? 0,
      // type: json['type'] ?? 0,
      // id_jenis_fundamental: json['id_jenis_fundamental'] ?? 0,
      // tahun: json['tahun'],
    );
  }
}

// List<TabelValuation> parseTabelValuation(int jsonString) {
//   final parsed = jsonDecode(jsonString);
//   final a = parsed['data']['fundamental'][0];

//   return List<TabelValuation>.from(
//       a..map((e) => TabelValuation.fromJson(e)).toList().reversed.toList()
//       // map((json) => TabelValuation.fromJson(json)),
//       );
// }

// class TabelValuation {
//   final double? der;
//   final double? annualizedRoe;
//   final double? gpm;
//   final double? npm;
//   final double? ear;
//   final double? marketCap;
//   final double? type;
//   final double? id_jenis_fundamental;
//   // double tahun;
//   //final double loan_to_depo_ratio;
//   // final double tahun;

//   TabelValuation({
//     required this.der,
//     required this.annualizedRoe,
//     required this.gpm,
//     required this.npm,
//     required this.ear,
//     required this.marketCap,
//     required this.type,
//     required this.id_jenis_fundamental,
//     // required this.tahun,
//     // required this.loan_to_depo_ratio,
//     // required this.tahun,
//   });

//   factory TabelValuation.fromJson(Map<String, dynamic> json) {
//     return TabelValuation(
//       // der: json['der'],
//       // annualizedRoe: json['annualized_roe'],
//       // gpm: json['gpm'],
//       // npm: json['npm'],
//       // ear: json['ear'],
//       // marketCap: json['market_cap'],

//       der: double.parse(json['der']),

//       annualizedRoe: double.parse(json['annualized_roe']),
//       gpm: double.parse(json['gpm']),
//       npm: double.parse(json['npm']),
//       ear: double.parse(json['ear']),
//       marketCap: double.parse(json['market_cap']),
//       type: json['type'] as double? ?? 0,
//       id_jenis_fundamental: json['id_jenis_fundamental'] as double? ?? 0,
//       // type: json['type'] ?? 0,
//       // id_jenis_fundamental: json['id_jenis_fundamental'] ?? 0,
//       // tahun: json['tahun'],
//     );
//   }
// }
