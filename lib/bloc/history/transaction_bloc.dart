import 'package:bloc/bloc.dart';
import '../../models/transactions/transaction_model.dart';
import '../../services/api_service.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final ApiService apiService;

  // Constructor
  TransactionBloc({required this.apiService}) : super(TransactionInitial()) {
    // Pastikan event handler terdaftar dengan benar
    on<FetchTransactionsEvent>((event, emit) async {
      emit(TransactionLoading());

      try {
        final response =
            await apiService.fetchTransactionsByUserId(event.userId);

        print('transaction');
        print(response);
        if (response['success'] == true) {
          final transactions = (response['data'] as List)
              .map((data) => Transaction.fromJson(data))
              .toList();
          emit(TransactionLoaded(transactions: transactions));
        } else {
          emit(const TransactionError(message: 'Failed to load transactions'));
        }
      } catch (e) {
        emit(TransactionError(message: 'Error: ${e.toString()}'));
      }
    });
  }
}
