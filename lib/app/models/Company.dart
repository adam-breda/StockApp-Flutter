class Company {
  String? ticker;
  String? name;
  String? logo;

  Company({this.ticker, this.name, this.logo});

  Company.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this.ticker;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
