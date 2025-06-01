abstract class DetailSikiEvent {}

class FetchSikiDetailEvent extends DetailSikiEvent {
  final String idSiki;

  FetchSikiDetailEvent(this.idSiki);
}
