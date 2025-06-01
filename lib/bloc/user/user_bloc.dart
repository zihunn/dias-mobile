import 'package:bloc/bloc.dart';
import 'package:DiAs/services/api_service.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // Menangani event FetchUserData
    on<FetchUserData>((event, emit) async {
      emit(UserLoading()); // Memulai dengan status loading
      try {
        final userData = await ApiService.getUserData();
        if (userData != null) {
          emit(UserLoaded(userData)); // Jika data berhasil dimuat
        } else {
          emit(UserError("Gagal memuat data user.")); // Jika gagal
        }
      } catch (e) {
        emit(UserError("Terjadi kesalahan: $e")); // Menangani kesalahan
      }
    });
  }
}
