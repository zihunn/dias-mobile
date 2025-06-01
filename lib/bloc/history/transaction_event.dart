import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactionsEvent extends TransactionEvent {
  final int userId;

  const FetchTransactionsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
