import 'package:DiAs/bloc/detail_siki/detail_siki_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'detail_siki_event.dart';

class DetailSikiBloc extends Bloc<DetailSikiEvent, DetailSikiState> {
  final ApiService apiService;

  DetailSikiBloc(this.apiService) : super(DetailSikiInitialState()) {
    on<FetchSikiDetailEvent>(_onFetchSikiDataEvent);
  }

  Future<void> _onFetchSikiDataEvent(
      FetchSikiDetailEvent event, Emitter<DetailSikiState> emit) async {
    emit(DetailSikiLoadingState());

    try {
      // Ambil data SDKI berdasarkan ID
      final detailSiki = await apiService.fetchSikiDetail(event.idSiki);
      emit(DetailSikiLoadedState(detailSiki)); // Pastikan detailSdki tidak null
    } catch (e) {
      emit(DetailSikiErrorState(e.toString())); // Tangani error jika API gagal
    }
  }
}
