import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'detail_sdki_event.dart';
import 'detail_sdki_state.dart';

class DetailSdkiBloc extends Bloc<DetailSdkiEvent, DetailSdkiState> {
  final ApiService apiService;

  DetailSdkiBloc(this.apiService) : super(DetailSdkiInitialState()){
        on<FetchSdkiDetailEvent>(_onFetchSdkiDataEvent);

  }
  

   Future<void> _onFetchSdkiDataEvent(
      FetchSdkiDetailEvent event, Emitter<DetailSdkiState> emit) async {
    emit(DetailSdkiLoadingState());

    try {
      // Ambil data SDKI berdasarkan ID
      final detailSdki = await apiService.fetchSdkiDetail(event.idSdki);
      emit(DetailSdkiLoadedState(detailSdki!)); // Pastikan detailSdki tidak null
    } catch (e) {
      emit(DetailSdkiErrorState(e.toString())); // Tangani error jika API gagal
    }
  }
}

