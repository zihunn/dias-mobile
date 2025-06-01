abstract class SlkiEvent {}

class FetchSlkiDataEvent extends SlkiEvent {
  final int page;

  FetchSlkiDataEvent({required this.page});
}

class FetchNextPageSlkiEvent extends SlkiEvent {
  final int nextPage;

  FetchNextPageSlkiEvent({required this.nextPage});
}
