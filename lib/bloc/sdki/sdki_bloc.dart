import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/sdki/sdki_model.dart';
import '../../services/api_service.dart';
import 'sdki_event.dart';
import 'sdki_state.dart';

class SdkiBloc extends Bloc<SdkiEvent, SdkiState> {
  final ApiService apiService;

  SdkiBloc(this.apiService) : super(SdkiInitialState()) {
    on<FetchSdkiDataEvent>(_onFetchSdkiDataEvent);
    on<FetchNextPageEvent>(_onFetchNextPageEvent);
  }

  Future<void> _onFetchSdkiDataEvent(
      FetchSdkiDataEvent event, Emitter<SdkiState> emit) async {
    emit(SdkiLoadingState());
    try {
      final response = await apiService.fetchSdkiData(page: event.page);
      emit(SdkiLoadedState(
        sdkiData: response.data?.data ?? [],
        currentPage: response.data?.currentPage ?? 1,
        totalPages: response.data?.lastPage ?? 1,
      ));
    } catch (e) {
      emit(SdkiErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchNextPageEvent(
      FetchNextPageEvent event, Emitter<SdkiState> emit) async {
    final currentState = state;
    if (currentState is SdkiLoadedState &&
        currentState.currentPage < currentState.totalPages) {
      try {
        final response = await apiService.fetchSdkiData(page: event.nextPage);
        final updatedData = List<SdkiDetail>.from(currentState.sdkiData)
          ..addAll(response.data?.data ?? []);
        emit(SdkiLoadedState(
          sdkiData: updatedData,
          currentPage: event.nextPage,
          totalPages: response.data?.lastPage ?? 1,
        ));
      } catch (e) {
        emit(SdkiErrorState(message: e.toString()));
      }
    }
  }
}
