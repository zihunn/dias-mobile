import 'package:DiAs/services/api_service.dart';
import 'package:DiAs/ui/screens/auth/login_screen.dart';
import 'package:DiAs/ui/screens/auth/otp_screen.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/ui/widgets/loading_button_widget.dart';
import 'package:DiAs/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_shadow/simple_shadow.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleRegister() async {
    // Validate input fields
    if (nameController.text.isEmpty) {
      _showError('Nama tidak boleh kosong');
      return;
    }

    if (emailController.text.isEmpty) {
      _showError('Email tidak boleh kosong');
      return;
    } else if (!_isValidEmail(emailController.text)) {
      _showError('Format email tidak valid');
      return;
    }

    if (passwordController.text.isEmpty) {
      _showError('Password tidak boleh kosong');
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiService = ApiService();
      final response = await apiService.registerUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response['status']) {
        // Success, navigate to OTP screen
        Navigator.push(
          context,
          PageTransition(
            child: OtpScreen(
              name: nameController.text,
              password: passwordController.text,
              email: emailController.text,
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      } else {
        // Show error message from response
        _showError(response['message']);
      }
    } catch (e) {
      print(e);
      _showError('Gagal melakukan registrasi');
    } finally {
      setState(() => isLoading = false);
    }
  }

// Utility function to show error messages
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

// Email validation using regex
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SimpleShadow(
                    opacity: 0.25,
                    color: Colors.black,
                    offset: const Offset(4, 2),
                    sigma: 2,
                    child: const Image(
                      width: 150.0,
                      height: 150.0,
                      image: AssetImage('assets/images/DiAs Logo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text("Register", style: AppTextStyles.heading1),
                const SizedBox(height: 5.0),
                const Text(
                  "Masukan personal informasi anda",
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Nama",
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                TextFieldWidget.standardTextField(
                    hintText: "Masukan Nama", controller: nameController),
                const SizedBox(height: 20.0),
                Text(
                  "Email",
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                TextFieldWidget.standardTextField(
                  hintText: "Masukan email",
                  controller: emailController,
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Password",
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                TextFieldWidget.standardTextField(
                    hintText: "Masukan password",
                    isPassword: true,
                    controller: passwordController),
                const SizedBox(
                  height: 50.0,
                ),
                LoadingButtonWidget(
                  isLoading: isLoading,
                  buttonText: 'Buat Akun',
                  onPressed: handleRegister,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: const LoginScreen(),
                            type: PageTransitionType.leftToRightWithFade,
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
