class PaymentChannel {
  final int paymentId;
  final String paymentName;

  PaymentChannel({
    required this.paymentId,
    required this.paymentName,
  });

  factory PaymentChannel.fromJson(Map<String, dynamic> json) {
    return PaymentChannel(
      paymentId: json['payment_id'],
      paymentName: json['payment_name'],
    );
  }
}
