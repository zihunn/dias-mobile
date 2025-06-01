import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/siki/siki_model.dart';
import '../../services/api_service.dart';
import 'siki_event.dart';
import 'siki_state.dart';

class SikiBloc extends Bloc<SikiEvent, SikiState> {
  final ApiService apiService;

  SikiBloc(this.apiService) : super(SikiInitialState()) {
    on<FetchSikiDataEvent>(_onFetchSikiDataEvent);
    on<FetchNextPageSikiEvent>(_onFetchNextPageSikiEvent);
  }

  // Fetch the initial set of Siki data
  Future<void> _onFetchSikiDataEvent(
      FetchSikiDataEvent event, Emitter<SikiState> emit) async {
    emit(SikiLoadingState());
    try {
      final response = await apiService.fetchSikiData(page: event.page);
      if (response.data != null) {
        emit(SikiLoadedState(
          sikiData: response.data?.items ?? [],
          currentPage: response.data?.currentPage ?? 1,
          totalPages: response.data?.lastPage ?? 1,
        ));
      } else {
        emit(SikiErrorState(message: 'No data found.'));
      }
    } catch (e) {
      emit(SikiErrorState(message: e.toString()));
    }
  }

  // Fetch data for the next page
  Future<void> _onFetchNextPageSikiEvent(
      FetchNextPageSikiEvent event, Emitter<SikiState> emit) async {
    final currentState = state;
    if (currentState is SikiLoadedState &&
        currentState.currentPage < currentState.totalPages) {
      try {
        final response = await apiService.fetchSikiData(page: event.nextPage);
        if (response.data != null) {
          final updatedData = List<SikiItemData>.from(currentState.sikiData)
            ..addAll(response.data?.items ?? []);
          emit(SikiLoadedState(
            sikiData: updatedData,
            currentPage: event.nextPage,
            totalPages: response.data?.lastPage ?? 1,
          ));
        } else {
          emit(SikiErrorState(message: 'No more data available.'));
        }
      } catch (e) {
        emit(SikiErrorState(message: e.toString()));
      }
    }
  }
}
