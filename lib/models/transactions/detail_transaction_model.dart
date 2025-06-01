class DetailTransaction {
  bool? success;
  String? status;
  DetailTransactionData? transaction;

  DetailTransaction({this.success, this.status, this.transaction});

  DetailTransaction.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    transaction = json['transaction'] != null
        ? DetailTransactionData.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class DetailTransactionData {
  int? id;
  int? userId;
  String? orderId;
  String? grossAmount;
  String? status;
  String? paymentType;
  String? transactionId;
  String? transactionTime;
  String? createdAt;
  String? updatedAt;

  DetailTransactionData(
      {this.id,
      this.userId,
      this.orderId,
      this.grossAmount,
      this.status,
      this.paymentType,
      this.transactionId,
      this.transactionTime,
      this.createdAt,
      this.updatedAt});

  DetailTransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    grossAmount = json['gross_amount'];
    status = json['status'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    transactionTime = json['transaction_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['gross_amount'] = grossAmount;
    data['status'] = status;
    data['payment_type'] = paymentType;
    data['transaction_id'] = transactionId;
    data['transaction_time'] = transactionTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
