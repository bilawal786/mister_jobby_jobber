import 'package:flutter/material.dart';

class ConstProvider with ChangeNotifier {
  int groupValue = 1;

  void checkGroupValue(int? value) {
    groupValue = value!;
    notifyListeners();
  }
}
