import 'package:DiAs/models/search/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchModels data;

  SearchLoaded(this.data);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
