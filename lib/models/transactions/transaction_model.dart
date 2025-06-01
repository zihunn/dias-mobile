class Transaction {
  final String orderId;
  final String status;

  Transaction({required this.orderId, required this.status});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      orderId: json['order_id'],
      status: json['status'],
    );
  }
}
