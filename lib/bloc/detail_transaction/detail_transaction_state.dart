import 'package:DiAs/models/transactions/detail_transaction_model.dart';
import 'package:equatable/equatable.dart';

// State untuk transaksi
abstract class DetailTransactionState extends Equatable {
  const DetailTransactionState();

  @override
  List<Object> get props => [];
}

// State awal sebelum data dimuat
class DetailTransactionInitial extends DetailTransactionState {}

// State saat data sedang dimuat
class DetailTransactionLoading extends DetailTransactionState {}

// State saat data berhasil dimuat
class DetailTransactionLoaded extends DetailTransactionState {
  final DetailTransaction detailTransaction;

  const DetailTransactionLoaded({required this.detailTransaction});

  @override
  List<Object> get props => [detailTransaction];
}

// State saat terjadi error
class DetailTransactionError extends DetailTransactionState {
  final String message;

  const DetailTransactionError({required this.message});

  @override
  List<Object> get props => [message];
}
