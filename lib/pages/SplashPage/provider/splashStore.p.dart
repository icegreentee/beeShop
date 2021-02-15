import 'package:flutter/material.dart';

class SplashStore with ChangeNotifier {
  int index = 0;
  void increment() {
    index++;
    notifyListeners();
  }

  void decrement() {
    index--;
    notifyListeners();
  }

  void set(int index) {
    this.index = index;
  }
}
