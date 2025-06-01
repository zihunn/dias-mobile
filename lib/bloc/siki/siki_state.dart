import '../../models/siki/siki_model.dart';

abstract class SikiState {}

class SikiInitialState extends SikiState {}

class SikiLoadingState extends SikiState {}

class SikiLoadedState extends SikiState {
  final List<SikiItemData> sikiData;
  final int currentPage;
  final int totalPages;

  SikiLoadedState({
    required this.sikiData,
    required this.currentPage,
    required this.totalPages,
  });
}

class SikiErrorState extends SikiState {
  final String message;

  SikiErrorState({required this.message});
}
