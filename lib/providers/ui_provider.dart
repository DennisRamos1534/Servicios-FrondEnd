import 'package:flutter/material.dart';


class UiProvider extends ChangeNotifier {
  
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt => this._selectedMenuOpt;
  set selectedMenuOpt(int valor) {
    this._selectedMenuOpt = valor;
    notifyListeners();
  }
}