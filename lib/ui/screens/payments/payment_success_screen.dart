// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:DiAs/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../styles/app_text_style.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const PaymentSuccessScreen({
    super.key,
    required this.user,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        padding: const EdgeInsets.all(12),
        animType: AnimType.rightSlide,
        dialogType: DialogType.success,
        transitionAnimationDuration: const Duration(milliseconds: 500),
        title: 'Yay! Pembayaran berhasil 🎉 ',
        desc:
            'Terima kasih telah memilih Elite Care! Nikmati fitur-fitur eksklusif kami',
        titleTextStyle: AppTextStyles.heading2,
        descTextStyle: AppTextStyles.caption,
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(userNonBloc: widget.user)),
          );
        },
        btnOkColor: Colors.green,
      ).show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
