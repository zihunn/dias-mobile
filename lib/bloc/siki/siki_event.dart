abstract class SikiEvent {}

class FetchSikiDataEvent extends SikiEvent {
  final int page;

  FetchSikiDataEvent({required this.page});
}

class FetchNextPageSikiEvent extends SikiEvent {
  final int nextPage;

  FetchNextPageSikiEvent({required this.nextPage});
}
