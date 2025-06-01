import 'package:DiAs/models/search/deatail_searach_model.dart';

abstract class DetailSearchState {}

class DetailSearchInitial extends DetailSearchState {}

class DetailSearchLoading extends DetailSearchState {}

class DetailSearchLoaded extends DetailSearchState {
  final ApiResponse data;

  DetailSearchLoaded(this.data);
}

class DetailSearchError extends DetailSearchState {
  final String message;

  DetailSearchError(this.message);
}
