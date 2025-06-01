import '../../models/transactions/transaction_response_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final TransactionResponse transactionResponse;

  PaymentSuccess(this.transactionResponse);
}

class PaymentFailure extends PaymentState {
  final String error;

  PaymentFailure(this.error);
}
