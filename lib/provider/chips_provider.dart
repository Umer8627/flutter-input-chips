import 'package:flutter/cupertino.dart';

class ChipsProvider extends ChangeNotifier {
  final List<String> _chips = [];
  List<String> get chips => _chips;

  void addChip({required String newChip}) {
    _chips.add(newChip);
    notifyListeners();
  }

  void removeChip({required String lastChip}) {
    _chips.remove(lastChip);
    notifyListeners();
  }
}
