
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../bloc/history/transaction_bloc.dart';
import '../../../bloc/history/transaction_event.dart';
import '../../../bloc/history/transaction_state.dart';
import '../../../services/api_service.dart';
import 'detail_transactions_screen.dart'; 
class HistoryTransactionsScreen extends StatelessWidget {
  final int idUser;
  const HistoryTransactionsScreen({
    super.key,
    required this.idUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "History Transaksi",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context) =>
              TransactionBloc(apiService: ApiService()), // BlocProvider di sini
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              // Setelah BlocProvider siap, kita kirimkan event
              if (state is TransactionInitial) {
                context.read<TransactionBloc>().add(
                      FetchTransactionsEvent(
                        userId: idUser,
                      ),
                    ); // Kirimkan event di sini
              }

              if (state is TransactionLoading) {
                return  Center(child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset('assets/lotties/loading.json'),
                  ),
                );
              } else if (state is TransactionLoaded) {
                return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transaction = state.transactions[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: transaction.status == "Success"
                            ? Colors.green.withOpacity(0.2)
                            : Colors.yellow.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/DiAs Logo No Text.png",
                            height: 50.0,
                            width: 50.0,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Elite Care",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Id Transaksi: ${transaction.orderId}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[500],
                                    fontSize: 14.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: DetailTransactionsScreen(
                                      orderId: transaction.orderId,
                                    ),
                                    type: PageTransitionType.rightToLeft),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: transaction.status == 'Success'
                                    ? Colors.green
                                    : Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                transaction.status == 'Success'
                                    ? "Success"
                                    : "Pending",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text("No Data"));
            },
          ),
        ));
  }
}
