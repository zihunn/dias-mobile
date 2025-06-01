abstract class DetailSdkiEvent {}

class FetchSdkiDetailEvent extends DetailSdkiEvent {
  final String idSdki;

  FetchSdkiDetailEvent(this.idSdki);
}
