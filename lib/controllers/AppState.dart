import 'package:flutter/foundation.dart';

enum NotifierState { busy, ideal, error }

class AppState extends ChangeNotifier {
  //final _postService = Routes().searchInspection();

  NotifierState _state = NotifierState.ideal;
  NotifierState get getState => _state;
  void setAppState(NotifierState state) {
    _state = state;
    notifyListeners();
  }
//
// late SearchCar _post;
// SearchCar get post => _post;
// void _setPost(SearchCar post) {
//   _post = post;
//   notifyListeners();
// }
//
// late Failure _failure;
// Failure get failure => _failure;
// void _setFailure(Failure failure) {
//   _failure = failure;
//   notifyListeners();
// }
}
