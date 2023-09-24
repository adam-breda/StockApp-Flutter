class Sekuritas {
  final int id;
  final String namaSekuritas;
  final double feeBeli;
  final double feeJual;

  Sekuritas({
    required this.id,
    required this.namaSekuritas,
    required this.feeBeli,
    required this.feeJual,
  });

  factory Sekuritas.fromJson(Map<String, dynamic> json) {
    return Sekuritas(
      id: json['id_sekuritas'],
      namaSekuritas: json['nama_sekuritas'],
      feeBeli: double.parse(json['fee_beli']),
      feeJual: double.parse(json['fee_jual']),
    );
  }
}
