import '../../models/slki/slki_model.dart';

abstract class SlkiState {}

class SlkiInitialState extends SlkiState {}

class SlkiLoadingState extends SlkiState {}

class SlkiLoadedState extends SlkiState {
  final List<SlkiItemData> slkiData;
  final int currentPage;
  final int totalPages;

  SlkiLoadedState({
    required this.slkiData,
    required this.currentPage,
    required this.totalPages,
  });
}

class SlkiErrorState extends SlkiState {
  final String message;

  SlkiErrorState({required this.message});
}
