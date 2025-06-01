import 'package:DiAs/models/siki/detail_siki_model.dart';

abstract class DetailSikiState {}

class DetailSikiInitialState extends DetailSikiState {}

class DetailSikiLoadingState extends DetailSikiState {}

class DetailSikiLoadedState extends DetailSikiState {
  final DetailSikiModel detailSiki;

  DetailSikiLoadedState(this.detailSiki);
}

class DetailSikiErrorState extends DetailSikiState {
  final String error;

  DetailSikiErrorState(this.error);
}
