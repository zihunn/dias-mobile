abstract class PaymentEvent {}

class CreateTransactionEvent extends PaymentEvent {
  final int userId;
  final double amount;
  final String token; // Tambahkan token

  CreateTransactionEvent({
    required this.userId,
    required this.amount,
    required this.token, // Inisialisasi token
  });
}
