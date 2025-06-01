abstract class DetailSearchEvent {}

class DetailSearchQueryChanged extends DetailSearchEvent {
  final String id;

  DetailSearchQueryChanged(this.id);
}
