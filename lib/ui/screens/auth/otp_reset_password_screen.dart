import 'package:flutter/material.dart';
import 'package:DiAs/services/api_service.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/ui/widgets/loading_button_widget.dart';
import 'package:DiAs/ui/widgets/textfield_widget.dart';

class OtpResetPasswordScreen extends StatefulWidget {
  final String email;
  final String password;

  const OtpResetPasswordScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<OtpResetPasswordScreen> createState() => _OtpResetPasswordScreenState();
}

class _OtpResetPasswordScreenState extends State<OtpResetPasswordScreen> {
  bool isLoading = false;
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> resetPassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final apiService = ApiService();
    final response = await apiService.resetPasswordWithOtp(
      widget.email,
      otpController.text,
      newPasswordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (response['status']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful')),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: Column(
          children: [
            const Text(
              "Masukkan kode OTP yang telah dikirimkan ke email Anda dan password baru.",
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15.0),
            TextFieldWidget.standardTextField(
              controller: otpController,
              hintText: 'Masukkan OTP',
            ),
            const SizedBox(height: 15.0),
            TextFieldWidget.standardTextField(
              controller: newPasswordController,
              hintText: 'Masukkan Password Baru',
              isPassword: true,
            ),
            const SizedBox(height: 15.0),
            TextFieldWidget.standardTextField(
              controller: confirmPasswordController,
              hintText: 'Konfirmasi Password Baru',
              isPassword: true,
            ),
            const Spacer(),
            LoadingButtonWidget(
              isLoading: isLoading,
              buttonText: "Reset Password",
              onPressed: resetPassword,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
