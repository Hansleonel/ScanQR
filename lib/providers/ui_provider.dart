import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOption = 0;

  int get getSelectedMenuOpt {
    return this._selectedMenuOption;
  }

  set setSelectedMenuOpt(int i) {
    this._selectedMenuOption = i;
    notifyListeners();
  }
}
