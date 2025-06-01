import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:DiAs/bloc/payment/payment_event.dart';
import 'package:DiAs/bloc/payment/payment_state.dart';
import 'package:DiAs/models/transactions/transaction_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
  }

  Future<void> _onCreateTransaction(
      CreateTransactionEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse('https://dias.lkp-ppik.id/api/payment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'gross_amount': event.amount,
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          final transactionResponse = TransactionResponse.fromJson(data);
          emit(PaymentSuccess(transactionResponse));
        } else {
          emit(PaymentFailure("Gagal membuat transaksi: ${data['message']}"));
        }
      } else if (response.statusCode == 400) {
        emit(PaymentFailure(
            "Gagal membuat transaksi: Anda memiliki panding transaksi"));
      } else {
        emit(PaymentFailure("Gagal membuat transaksi"));
      }
    } catch (e) {
      emit(PaymentFailure("Terjadi kesalahan: ${e.toString()}"));
    }
  }
}
