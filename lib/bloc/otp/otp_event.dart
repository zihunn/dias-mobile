import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends OtpEvent {
  final String email;
  final String otpCode;
  final String name;
  final String password;

  const SendOtpEvent(this.email, this.otpCode, this.name, this.password);

  @override
  List<Object> get props => [email, otpCode];
}
