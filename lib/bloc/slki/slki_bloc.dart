import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/slki/slki_model.dart';
import '../../services/api_service.dart';
import 'slki_event.dart';
import 'slki_state.dart';

class SlkiBloc extends Bloc<SlkiEvent, SlkiState> {
  final ApiService apiService;

  SlkiBloc(this.apiService) : super(SlkiInitialState()) {
    on<FetchSlkiDataEvent>(_onFetchSlkiDataEvent);
    on<FetchNextPageSlkiEvent>(_onFetchNextPageSlkiEvent);
  }

  // Fetch the initial set of SLKI data
  Future<void> _onFetchSlkiDataEvent(
      FetchSlkiDataEvent event, Emitter<SlkiState> emit) async {
    emit(SlkiLoadingState());
    try {
      final response = await apiService.fetchSlkiData(page: event.page);
      if (response.data != null) {
        emit(SlkiLoadedState(
          slkiData: response.data?.items ?? [],
          currentPage: response.data?.currentPage ?? 1,
          totalPages: response.data?.lastPage ?? 1,
        ));
      } else {
        emit(SlkiErrorState(message: 'No data found.'));
      }
    } catch (e) {
      emit(SlkiErrorState(message: e.toString()));
    }
  }

  // Fetch data for the next page
  Future<void> _onFetchNextPageSlkiEvent(
      FetchNextPageSlkiEvent event, Emitter<SlkiState> emit) async {
    final currentState = state;
    if (currentState is SlkiLoadedState &&
        currentState.currentPage < currentState.totalPages) {
      try {
        final response = await apiService.fetchSlkiData(page: event.nextPage);
        if (response.data != null) {
          final updatedData = List<SlkiItemData>.from(currentState.slkiData)
            ..addAll(response.data?.items ?? []);
          emit(SlkiLoadedState(
            slkiData: updatedData,
            currentPage: event.nextPage,
            totalPages: response.data?.lastPage ?? 1,
          ));
        } else {
          emit(SlkiErrorState(message: 'No more data available.'));
        }
      } catch (e) {
        emit(SlkiErrorState(message: e.toString()));
      }
    }
  }
}
