class FilterNotifier {
  String _from = DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day)
      .toUtc()
      .toIso8601String();
  String _to = DateTime.now().toUtc().toIso8601String();

  String get from => _from;
  String get to => _to;

  void setFrom(String from) {
    _from = from;
    //// notifyListeners();
  }

  void setTo(String to) {
    _to = to;
    //notifyListeners();
  }
}
