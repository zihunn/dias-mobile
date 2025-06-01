abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> userData;

  AuthSuccess(this.userData);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class UpdateProfileSuccess extends AuthState {
  final Map<String, dynamic> updatedUser;

  UpdateProfileSuccess(this.updatedUser);
}

class UpdateProfileFailure extends AuthState {
  final String message;

  UpdateProfileFailure(this.message);
}
