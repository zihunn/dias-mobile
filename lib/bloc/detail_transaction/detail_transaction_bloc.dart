import 'package:bloc/bloc.dart';
import 'package:DiAs/bloc/detail_transaction/detail_transaction_event.dart';
import 'package:DiAs/bloc/detail_transaction/detail_transaction_state.dart';
import 'package:DiAs/models/transactions/detail_transaction_model.dart';
import '../../services/api_service.dart';

class DetailTransactionBloc
    extends Bloc<DetailTransactionEvent, DetailTransactionState> {
  final ApiService apiService;

  // Constructor
  DetailTransactionBloc({required this.apiService})
      : super(DetailTransactionInitial()) {
    // Pastikan event handler terdaftar dengan benar
    on<FetchDetailTransactionsEvent>((event, emit) async {
      emit(DetailTransactionLoading());

      try {
        final response =
            await apiService.fetchDetailHistoryTransaction(event.orderId);

        print(response['success']);
        if (response['success'] == true) {
          // Mengambil data transaksi dari response['transaction']
          final transactionData = response['transaction'];
          final transaction = DetailTransactionData.fromJson(transactionData);

          // Membuat DetailTransaction untuk dikirimkan ke UI
          final detailTransaction = DetailTransaction(
            success: response['success'],
            status: response['status'],
            transaction: transaction,
          );

          // Mengirimkan data DetailTransaction yang sudah dimuat
          emit(DetailTransactionLoaded(detailTransaction: detailTransaction));
        } else {
          emit(const DetailTransactionError(
              message: 'Failed to load transactions'));
        }
      } catch (e) {
        emit(DetailTransactionError(message: 'Error: ${e.toString()}'));
      }
    });
  }
}
