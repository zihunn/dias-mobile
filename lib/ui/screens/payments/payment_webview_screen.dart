import 'dart:convert';

import 'package:DiAs/bloc/user/user_bloc.dart';
import 'package:DiAs/bloc/user/user_event.dart';
import 'package:DiAs/bloc/user/user_state.dart';
import 'package:DiAs/ui/screens/payments/payment_error_screen.dart';
import 'package:DiAs/ui/screens/payments/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url;

  const PaymentWebView({super.key, required this.url});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  bool isLoading = true; // Menambahkan flag isLoading

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) async {
          setState(() {
            isLoading = true; // Mulai loading
          });
          final prefs = await SharedPreferences.getInstance();
          final user = prefs.getString('user');
          print('Loading: $url');

          // Memeriksa URL untuk status transaksi yang berhasil
          if (url.contains('status_code=200&transaction_status=settlement')) {
            // Hanya memicu BLoC jika transaksi berhasil
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserBloc()
                    ..add(
                        FetchUserData()), // Memicu event untuk mengambil data user
                  child: Scaffold(
                    body: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          // Menampilkan indikator loading hanya jika BLoC sedang memuat data
                          return Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child:
                                  Lottie.asset('assets/lotties/loading.json'),
                            ),
                          );
                        } else if (state is UserLoaded) {
                          // Menampilkan PaymentSuccessScreen jika data berhasil didapat
                          return PaymentSuccessScreen(user: state.userData);
                        } else if (state is UserError) {
                          // Menampilkan pesan error jika terjadi kesalahan
                          return Center(child: Text('Error: ${state.message}'));
                        }
                        return const Center(child: Text('Memuat data user...'));
                      },
                    ),
                  ),
                ),
              ),
            );
          } else if (url.contains('status_code=202&transaction_status=dany')) {
            // Menampilkan PaymentErrorScreen jika transaksi gagal
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentErrorScreen(
                  title: 'Oops! Pembayaran gagal',
                  desc: 'Silakan coba lagi atau gunakan metode pembayaran lain',
                  user: jsonDecode(user!),
                ),
              ),
            );
          } else if (url
              .contains('status_code=201&transaction_status=pending')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentErrorScreen(
                  title: 'Oops! Pembayaran Belum Selesai',
                  desc:
                      'Selesaikan pembayaran Anda atau pilih metode lain di halaman pembayaran.',
                  user: jsonDecode(user!),
                ),
              ),
            );
          } else if (url.contains('http://example.com/')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserBloc()
                    ..add(
                        FetchUserData()), // Memicu event untuk mengambil data user
                  child: Scaffold(
                    body: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          // Menampilkan indikator loading hanya jika BLoC sedang memuat data
                          return Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child:
                                  Lottie.asset('assets/lotties/loading.json'),
                            ),
                          );
                        } else if (state is UserLoaded) {
                          // Menampilkan PaymentSuccessScreen jika data berhasil didapat
                          return PaymentSuccessScreen(user: state.userData);
                        } else if (state is UserError) {
                          // Menampilkan pesan error jika terjadi kesalahan
                          return Center(child: Text('Error: ${state.message}'));
                        }
                        return const Center(child: Text('Memuat data user...'));
                      },
                    ),
                  ),
                ),
              ),
            );
          }
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false; // Selesai loading
          });
          print('Finished loading: $url');
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ), // Menampilkan indikator loading
            ),
        ],
      ),
    );
  }
}
