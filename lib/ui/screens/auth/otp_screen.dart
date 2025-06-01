import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:DiAs/services/api_service.dart';

import '../../../bloc/otp/otp_bloc.dart';
import '../../../bloc/otp/otp_event.dart';
import '../../../bloc/otp/otp_state.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text_style.dart';
import '../../widgets/loading_button_widget.dart';
import '../../widgets/textfield_widget.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String? name;
  final String password;
  final String email;

  const OtpScreen({
    super.key,
    this.name,
    required this.password,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;
  late Timer _timer;
  int _remainingTime = 30;
  bool _canResendCode = false;

  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResendCode = false;
    _remainingTime = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _canResendCode = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    super.dispose();
  }

  String get otpCode =>
      "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";

  void handleVerification(BuildContext context) {
    context.read<OtpBloc>().add(SendOtpEvent(
        widget.email, otpCode, widget.name ?? '', widget.password));
  }

  Future<void> handleRegister() async {
    try {
      final apiService = ApiService();
      final response = await apiService.registerUser(
        name: widget.name ?? '',
        email: widget.email,
        password: widget.password,
      );

      if (response['status']) {
        // Berhasil, navigasi ke layar OTP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      } else {
        // Tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal melakukan registrasi')),
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: true,
        body: BlocProvider(
          create: (context) => OtpBloc(ApiService()),
          child: BlocConsumer<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is OtpSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP Verified Successfully')),
                );
              } else if (state is OtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: screenHeight * 0.8,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.3,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/sent-email.png'),
                            ),
                          ),
                        ),
                        Text(
                          "${'Kami mengirimkan 4 digit kode ke email'} ${widget.email}",
                          style: AppTextStyles.caption,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFieldWidget.OtpWidget(
                              context: context,
                              controller: otpController1,
                            ),
                            TextFieldWidget.OtpWidget(
                              context: context,
                              controller: otpController2,
                            ),
                            TextFieldWidget.OtpWidget(
                              context: context,
                              controller: otpController3,
                            ),
                            TextFieldWidget.OtpWidget(
                              context: context,
                              controller: otpController4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        _canResendCode
                            ? TextButton(
                                onPressed: () {
                                  _startTimer();
                                  handleRegister();
                                },
                                child: const Text(
                                  "Kirim Ulang",
                                  style: TextStyle(color: Colors.amber),
                                ),
                              )
                            : Text(
                                "Kirim ulang kode dalam $_remainingTime detik",
                                style: const TextStyle(color: Colors.grey),
                              ),
                        const Spacer(),
                        // const SizedBox(height: 20.0),
                        LoadingButtonWidget(
                          isLoading: state is OtpLoading,
                          buttonText: "Verifikasi",
                          onPressed: () => handleVerification(context),
                          backgroundColor: AppColors.secondaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
