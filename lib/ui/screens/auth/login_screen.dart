import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import '../../../bloc/login/login_state.dart';
import 'change_password_screen.dart';
import 'register_screen.dart';
import '../../styles/app_text_style.dart';
import '../../widgets/loading_button_widget.dart';
import '../../widgets/navbar_widget.dart';
import '../../widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  // Validasi Email dan Password
  void _validateAndLogin() {
    setState(() {
      _emailError = _isValidEmail(_emailController.text)
          ? null
          : 'Format email tidak valid';
      _passwordError = _passwordController.text.isNotEmpty
          ? null
          : 'Password tidak boleh kosong';
    });

    if (_emailError == null && _passwordError == null) {
      context.read<AuthBloc>().add(
            LoginEvent(
              _emailController.text,
              _passwordController.text,
            ),
          );
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final PersistentTabController controllerTab;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  // Tampilkan indikator loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/lotties/loading.json'),
                      ),
                    ),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.of(context).pop(); // Tutup dialog loading
                  print('Login Screen');
                  print(state.userData);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavbarWidget(
                              userNonBloc: state.userData,
                            )),
                  );
                } else if (state is AuthFailure) {
                  Navigator.of(context).pop(); // Tutup dialog loading
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
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
                  const Text("Login", style: AppTextStyles.heading1),
                  const SizedBox(height: 5.0),
                  const Text(
                    "Silakan login untuk melanjutkan ke layanan kami.",
                    style: AppTextStyles.caption,
                  ),
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
                    controller: _emailController,
                  ),
                  if (_emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _emailError!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
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
                    controller: _passwordController,
                  ),
                  if (_passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _passwordError!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        foregroundColor:
                            WidgetStatePropertyAll<Color>(Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                      child: const Text("Lupa Password?"),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return LoadingButtonWidget(
                        isLoading: isLoading,
                        buttonText: 'Login',
                        onPressed: _validateAndLogin,
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tidak punya akun?",
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
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const RegisterScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Text(
                          "Register",
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
      ),
    );
  }
}
