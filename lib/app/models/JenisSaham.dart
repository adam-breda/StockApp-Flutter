class JenisSaham {
  final int id_jenis_saham;
  final String jenis_saham;

  JenisSaham({
    required this.id_jenis_saham,
    required this.jenis_saham,
  });

  factory JenisSaham.fromJson(Map<String, dynamic> json) {
    return JenisSaham(
      id_jenis_saham: json['id_jenis_saham'],
      jenis_saham: json['jenis_saham'],
    );
  }
}
