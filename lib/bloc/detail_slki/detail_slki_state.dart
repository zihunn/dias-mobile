import '../../models/slki/detail_slki_model.dart';

abstract class DetailSlkiState {}

class DetailSlkiInitialState extends DetailSlkiState {}

class DetailSlkiLoadingState extends DetailSlkiState {}

class DetailSlkiLoadedState extends DetailSlkiState {
  final DetailSlki detailSlki;

  DetailSlkiLoadedState(this.detailSlki);
}

class DetailSlkiErrorState extends DetailSlkiState {
  final String error;

  DetailSlkiErrorState(this.error);
}
