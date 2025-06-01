import 'package:equatable/equatable.dart';

abstract class DetailTransactionEvent extends Equatable {
  const DetailTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailTransactionsEvent extends DetailTransactionEvent {
  final String orderId;

  const FetchDetailTransactionsEvent({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
