import 'package:inspection_admin/models/Summary.dart';

class SummaryNotifier {
  Summary? _summary;
  Summary? get getSummary => _summary;

  void setSummary(Summary summary) {
    _summary = summary;
    //  notifyListeners();
  }
}
