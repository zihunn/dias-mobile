abstract class DetailSlkiEvent {}

class FetchSlkiDetailEvent extends DetailSlkiEvent {
  final String idSdki;

  FetchSlkiDetailEvent(this.idSdki);
}
