class PortofolioBeli {
  int idPortofolioBeli;
  int idSaham;
  int userId;
  int jenisSaham;
  int volume;
  String tanggalBeli;
  int hargaBeli;
  String idSekuritas;

  PortofolioBeli({
    required this.idPortofolioBeli,
    required this.idSaham,
    required this.userId,
    required this.jenisSaham,
    required this.volume,
    required this.tanggalBeli,
    required this.hargaBeli,
    required this.idSekuritas,
  });

  factory PortofolioBeli.fromJson(Map<String, dynamic> json) {
    return PortofolioBeli(
      idPortofolioBeli: json['id_portofolio_beli'],
      idSaham: json['id_saham'],
      userId: json['user_id'],
      jenisSaham: json['jenis_saham'],
      volume: json['volume'],
      tanggalBeli: json['tanggal_beli'],
      hargaBeli: json['harga_beli'],
      idSekuritas: json['id_sekuritas'],
    );
  }
}
