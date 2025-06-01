import '../../models/sdki/sdki_model.dart';

abstract class SdkiState {}

class SdkiInitialState extends SdkiState {}

class SdkiLoadingState extends SdkiState {}

class SdkiLoadedState extends SdkiState {
  final List<SdkiDetail> sdkiData;
  final int currentPage;
  final int totalPages;

  SdkiLoadedState({
    required this.sdkiData,
    required this.currentPage,
    required this.totalPages,
  });
}

class SdkiErrorState extends SdkiState {
  final String message;

  SdkiErrorState({required this.message});
}
