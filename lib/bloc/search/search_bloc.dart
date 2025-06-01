import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;

  SearchBloc(this.apiService) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading()); // Emit loading state
    try {
      final data = await apiService.fetchSearchResults(event.query);
      emit(SearchLoaded(data)); // Pass the Map directly
    } catch (e) {
      emit(SearchError(e.toString())); // Emit error state
    }
  }
}

