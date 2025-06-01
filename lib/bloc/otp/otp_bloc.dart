import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final ApiService apiService;

  OtpBloc(this.apiService) : super(OtpInitial()) {
    on<SendOtpEvent>(_onSendOtp);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    try {
      final response = await apiService.verifyOtp(
        email: event.email,
        password: event.password,
        name: event.name,
        otpCode: event.otpCode,
      );

      if (response['status']) {
        emit(OtpSuccess());
      } else {
        emit(OtpFailure(response['message'] ?? 'Verification failed'));
      }
    } catch (e) {
      emit(OtpFailure('Failed to verify OTP: ${e.toString()}'));
    }
  }
}
