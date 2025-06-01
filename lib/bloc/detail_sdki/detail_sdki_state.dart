import '../../models/sdki/detail_sdki_model.dart';

abstract class DetailSdkiState {}

class DetailSdkiInitialState extends DetailSdkiState {}

class DetailSdkiLoadingState extends DetailSdkiState {}

class DetailSdkiLoadedState extends DetailSdkiState {
  final DetailSdkiModel detailSdki;

  DetailSdkiLoadedState(this.detailSdki);
}

class DetailSdkiErrorState extends DetailSdkiState {
  final String error;

  DetailSdkiErrorState(this.error);
}
