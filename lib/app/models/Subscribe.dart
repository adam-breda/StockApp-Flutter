class Subscribe {
  final int id_subscription;
  final int id_subscriber;
  final int id_analyst;
  final int status;
  final int expired;
  // final String status;
  // final DateTime expired;

  Subscribe({
    required this.id_subscription,
    required this.id_subscriber,
    required this.id_analyst,
    required this.status,
    required this.expired,
    // required this.status,
    // required this.expired,
  });

  factory Subscribe.fromJson(Map<String, dynamic> json) {
    return Subscribe(
      id_subscription: json['id_subscription'],
      id_subscriber: json['id_subscriber'],
      id_analyst: json['id_analyst'],
      status: json['status'],
      expired: json['expired'],
      // status: json['status'],
      // expired: json['expired'],
    );
  }
}
