import 'dart:convert';
import 'package:DiAs/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;

  AuthBloc(this.apiService) : super(AuthInitial()) {
    on<AppStartedEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson != null) {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;

        emit(AuthSuccess(userData));
      } else {
        emit(AuthInitial());
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await apiService.login(
        email: event.email,
        password: event.password,
      );

      if (response['status'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['token']);

        print('Login Bloc');
        print(response);
        await saveUserData(response);
        await prefs.setString('user', jsonEncode(response));

        emit(AuthSuccess(response));
      } else {
        emit(AuthFailure(response['message']));
      }
    });

    on<LogoutEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      emit(AuthInitial());
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token == null) {
          emit(AuthFailure('Token not found'));
          return;
        }

        // Memanggil API untuk memperbarui profil
        final response = await apiService.updateProfile(
          token: token,
          name: event.name,
          gender: event.gender,
          birthDate: event.birthDate,
          profileImage: event.profileImage,
        );

        // Periksa status code sebelum memperbarui data pengguna di SharedPreferences
        if (response['statusCode'] == 200) {
          final updatedUser = response['userData'];
          // await saveUserData(updatedUser['userData']);
          print('update user bloc');
          print(updatedUser);
          await saveUserData(updatedUser);
          await prefs.setString('user', jsonEncode(updatedUser['user']));
          emit(UpdateProfileSuccess(updatedUser));
        } else {
          emit(UpdateProfileFailure(
              'Failed to update profile with status code: ${response['statusCode']}'));
        }
      } catch (e) {}
    });
  }
}
