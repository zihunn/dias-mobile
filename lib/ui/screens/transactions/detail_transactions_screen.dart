// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:DiAs/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:DiAs/bloc/detail_transaction/detail_transaction_event.dart';
import 'package:DiAs/bloc/detail_transaction/detail_transaction_state.dart';
import 'package:DiAs/bloc/payment/payment_state.dart';
import 'package:DiAs/services/api_service.dart';
import 'package:DiAs/ui/screens/payments/payment_webview_screen.dart';
import 'package:DiAs/ui/widgets/loading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:page_transition/page_transition.dart';

import '../../../bloc/payment/payment_bloc.dart';

class DetailTransactionsScreen extends StatefulWidget {
  final String orderId;
  const DetailTransactionsScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailTransactionsScreen> createState() =>
      _DetailTransactionsScreenState();
}

class _DetailTransactionsScreenState extends State<DetailTransactionsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var format = NumberFormat("#,##0", "id_ID");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.orderId),
        actions: const [],
      ),
      body: BlocProvider(
        create: (context) => DetailTransactionBloc(
          apiService: ApiService(),
        ),
        child: BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
          builder: (context, state) {
            // Jika Status State nya Inisalisasi
            if (state is DetailTransactionInitial) {
              context.read<DetailTransactionBloc>().add(
                    FetchDetailTransactionsEvent(orderId: widget.orderId),
                  );
            }

            // Jika Status State nya Loading
            if (state is DetailTransactionLoading) {
              return Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/lotties/loading.json'),
                ),
              );
              // Jika Status State nya Loaded Data
            } else if (state is DetailTransactionLoaded) {
              var data = state.detailTransaction.transaction;
              String formattedAmount =
                  format.format(double.tryParse(data!.grossAmount!) ?? 0.0);
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          data.status == 'Success'
                              ? 'assets/lotties/success.json'
                              : 'assets/lotties/pending.json',
                          alignment: Alignment.center,
                        ),
                      ),
                      Text(
                        data.status == 'Success'
                            ? "Pembayaran Berhasil"
                            : "Pembayaran Pending",
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        data.status == 'Success'
                            ? "Anda berhasil melakukan pembayaran Elite Care"
                            : "Ayo selesaikan pembayaran Elite Care",
                        style: AppTextStyles.bodyText.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: screenWidth,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Detail Transaksi",
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaksi ID",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  data.orderId ?? '',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tanggal",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  data.transactionTime?.split(' ').first ?? '',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jam",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  data.transactionTime?.split(' ').last ?? '',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Nominal",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formattedAmount,
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Metode Pembayaran",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  data.paymentType ?? '-',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: data.status == 'Success'
                                        ? Colors.green[100]
                                        : Colors.yellow[100],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        data.status == 'Success'
                                            ? Icons.check
                                            : Icons.timelapse_sharp,
                                        size: 20.0,
                                        color: data.status == 'Success'
                                            ? Colors.green
                                            : Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        data.status ?? '-',
                                        style: AppTextStyles.caption.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: data.status == 'Success'
                                              ? Colors.green
                                              : Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Text(
                                  formattedAmount,
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      data.status == 'Success'
                          ? const SizedBox()
                          : BlocListener<PaymentBloc, PaymentState>(
                              listener: (context, state) {
                                if (PaymentState is! PaymentLoading) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // Tutup dialog loading jika ada
                                }
                                if (PaymentState is PaymentLoading) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Lottie.asset(
                                            'assets/lotties/loading.json'),
                                      ),
                                    ),
                                  );
                                } else if (PaymentState is PaymentSuccess) {
                                  Navigator.pop(context);
                                  var token = data.transactionId;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         PaymentWebView(
                                  //       url:
                                  //           'https://app.sandbox.midtrans.com/snap/v4/redirection/$token',
                                  //     ),
                                  //   ),
                                  // );
                                } else if (PaymentState is PaymentFailure) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('error')),
                                  );
                                }
                              },
                              child: LoadingButtonWidget(
                                isLoading: isLoading,
                                buttonText: 'Lanjutkan Pembayaran',
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  var token = data.transactionId;

                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: PaymentWebView(
                                          // url:
                                          //     'https://app.sandbox.midtrans.com/snap/v4/redirection/$token',
                                          url:
                                              'https://app.midtrans.com/snap/v4/redirection/$token',
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text("No Data"));
          },
        ),
      ),
    );
  }
}
