import 'package:flutter/cupertino.dart';

import 'AppState.dart';

class FilterProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.ideal;
  NotifierState get getState => _state;
  void setFilterState(NotifierState state) {
    _state = state;
    notifyListeners();
  }
}
