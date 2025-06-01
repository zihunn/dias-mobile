abstract class SdkiEvent {}

class FetchSdkiDataEvent extends SdkiEvent {
  final int page;

  FetchSdkiDataEvent({required this.page});
}

class FetchNextPageEvent extends SdkiEvent {
  final int nextPage;

  FetchNextPageEvent({required this.nextPage});
}
