import 'package:flutter/foundation.dart';

class PageControl extends ChangeNotifier {
  int _currentPage = 1;

  int get currentPage => _currentPage;

  void changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
