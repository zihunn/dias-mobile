import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'detail_slki_event.dart';
import 'detail_slki_state.dart';

class DetailSlkiBloc extends Bloc<DetailSlkiEvent, DetailSlkiState> {
  final ApiService apiService;

  DetailSlkiBloc(this.apiService) : super(DetailSlkiInitialState()) {
    on<FetchSlkiDetailEvent>(_onFetchSdkiDataEvent);
  }

  Future<void> _onFetchSdkiDataEvent(
      FetchSlkiDetailEvent event, Emitter<DetailSlkiState> emit) async {
    emit(DetailSlkiLoadingState());

    try {
      // Ambil data SDKI berdasarkan ID
      final detailSdki = await apiService.fetchSlkiDetail(event.idSdki);
      emit(DetailSlkiLoadedState(detailSdki)); // Pastikan detailSdki tidak null
    } catch (e) {
      emit(DetailSlkiErrorState(e.toString())); // Tangani error jika API gagal
    }
  }
}
