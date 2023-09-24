class Tagihan {
  final int id;
  final String reference;
  final String nama;
  final int jumlah;
  final String status;
  final String? tgl_tagihan;
  final String? metode_pembayaran;
  final int user_id;

  Tagihan({
    required this.id,
    required this.reference,
    required this.nama,
    required this.jumlah,
    required this.status,
    required this.tgl_tagihan,
    required this.metode_pembayaran,
    required this.user_id,
  });

  factory Tagihan.fromJson(Map<String, dynamic> json) {
    return Tagihan(
      id: json['id_tagihan'],
      reference: json['reference'],
      nama: json['nama_tagihan'],
      jumlah: json['jumlah'],
      status: json['status'],
      tgl_tagihan: json['tgl_tagihan'],
      metode_pembayaran: json['metode_pembayaran'],
      user_id: json['user_id'],
    );
  }
}
