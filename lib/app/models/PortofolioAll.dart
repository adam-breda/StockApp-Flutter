class PortofolioAll {
  int idPortofolio;
  String namaSaham;
  String status;
  int userId;
  int jenisSaham;
  int volume;
  String tanggal;
  String namaSekuritas;
  int harga;
  String fee;

  PortofolioAll({
    required this.idPortofolio,
    required this.namaSaham,
    required this.status,
    required this.userId,
    required this.jenisSaham,
    required this.volume,
    required this.tanggal,
    required this.namaSekuritas,
    required this.harga,
    required this.fee,
  });

  factory PortofolioAll.fromJson(Map<String, dynamic> json) {
    return PortofolioAll(
      idPortofolio: json['id_portofolio'],
      namaSaham: json['nama_saham'],
      status: json['status'],
      userId: json['user_id'],
      jenisSaham: json['jenis_saham'],
      volume: json['volume'],
      tanggal: json['tanggal'],
      namaSekuritas: json['nama_sekuritas'],
      harga: json['harga'],
      fee: json['fee'],
    );
  }
}
