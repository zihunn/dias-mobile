import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'detail_search_event.dart';
import 'detail_search_state.dart';

class DetailSearchBloc extends Bloc<DetailSearchEvent, DetailSearchState> {
  final ApiService apiService;

  DetailSearchBloc(this.apiService) : super(DetailSearchInitial()) {
    on<DetailSearchQueryChanged>(_onDetailSearchQueryChanged);
  }

  Future<void> _onDetailSearchQueryChanged(
    DetailSearchQueryChanged event,
    Emitter<DetailSearchState> emit,
  ) async {
    emit(DetailSearchLoading()); // Emit loading state
    try {
      final data = await apiService.fetchSearchDetail(event.id);
      emit(DetailSearchLoaded(data)); // Emit loaded state with data
    } catch (e) {
      emit(DetailSearchError(e.toString())); // Emit error state if failed
    }
  }
}
