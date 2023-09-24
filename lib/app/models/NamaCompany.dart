class NamaCompany {
  String? id_saham;
  String? nama_saham;
  String? nama_perusahaan;
  String? pic;

  NamaCompany(
      {required this.id_saham,
      required this.nama_saham,
      required this.nama_perusahaan,
      required this.pic});

  // NamaCompany.fromJson(Map<String, dynamic> json) {
  //   id_saham = json['id_saham'];
  //   nama_saham = json['nama_saham'];
  //   nama_perusahaan = json['nama_perusahaan'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataNamaCompany = new Map<String, dynamic>();
    dataNamaCompany['id_saham'] = this.id_saham;
    dataNamaCompany['nama_saham'] = this.nama_saham;
    dataNamaCompany['nama_perusahaan'] = this.nama_perusahaan;
    dataNamaCompany['pic'] = this.pic;
    return dataNamaCompany;
  }
}
