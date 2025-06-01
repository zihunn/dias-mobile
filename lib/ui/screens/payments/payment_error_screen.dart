// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:DiAs/ui/styles/app_text_style.dart';

import '../home_screen.dart';

class PaymentErrorScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String title;
  final String desc;
  const PaymentErrorScreen({
    super.key,
    required this.user,
    required this.title,
    required this.desc,
  });

  @override
  State<PaymentErrorScreen> createState() => _PaymentErrorScreenState();
}

class _PaymentErrorScreenState extends State<PaymentErrorScreen> {
  @override
  void initState() {
    super.initState();
    _showErrorDialog();
  }

  void _showErrorDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        padding: const EdgeInsets.all(12),
        animType: AnimType.rightSlide,
        dialogType: DialogType.error,
        transitionAnimationDuration: const Duration(milliseconds: 500),
        title: widget.title,
        desc: widget.desc,
        titleTextStyle: AppTextStyles.heading2,
        descTextStyle: AppTextStyles.caption,
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(userNonBloc: widget.user)),
          );
        },
        btnOkColor: Colors.red,
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
