import 'dart:io';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String? gender;
  final String? birthDate;
  final File? profileImage;

  UpdateProfileEvent({
    required this.name,
    this.gender,
    this.birthDate = '',
    this.profileImage,
  });
}

class AppStartedEvent extends AuthEvent {}
