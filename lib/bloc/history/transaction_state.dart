import 'package:DiAs/models/transactions/transaction_model.dart';
import 'package:equatable/equatable.dart';

// State untuk transaksi
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

// State awal sebelum data dimuat
class TransactionInitial extends TransactionState {}

// State saat data sedang dimuat
class TransactionLoading extends TransactionState {}

// State saat data berhasil dimuat
class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

// State saat terjadi error
class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}
