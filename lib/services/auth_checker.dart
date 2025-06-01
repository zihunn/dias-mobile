import 'dart:convert';
import 'package:DiAs/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_state.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/widgets/navbar_widget.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    ApiService.getUserData();

    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      print('get user data');
      print(userJson);
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            );
          } else {
            if (snapshot.data != null) {
              print('auth chechker');
              print(snapshot.data);
              return NavbarWidget(
                userNonBloc: snapshot.data!,
              );
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
