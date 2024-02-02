import 'package:flutter/material.dart';
import 'package:newsupon/view/categoryScreen.dart';
import 'package:newsupon/view/homeScreen.dart';
import 'package:newsupon/view/searchScreen.dart';

class BottomController
    with
        ChangeNotifier //it behave as mixin so abstract functionality come with that,if use extend then it treat as extends ,no scope for abstrat
{
  int selectedIndex = 0;
  List<Widget> screens = [HomeScreen(), CategoryScreen(), SearchScreen()];

  void onTapItem(tappedIndex) {
      selectedIndex = tappedIndex;
    notifyListeners();
  }
}
