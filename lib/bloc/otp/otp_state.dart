import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailure extends OtpState {
  final String error;

  const OtpFailure(this.error);

  @override
  List<Object> get props => [error];
}
