import 'package:flutter/widgets.dart';

class DrawerOptionProvider extends ChangeNotifier {
  Map<String, bool> drawerOptions = {
    "isHomeDrawerTab": true,
    "isBoardMembertab": false,
    "isPastEventTab": false,
    "isBlogTab": false,
    "isAboutTab" : false,
    'isSpeakerSessionTab' : false ,
  };
  String current = "isHomeDrawerTab";

  void updateDrawerOption(String option) {
    drawerOptions[current] = false;
    current = option;
    drawerOptions[current] = true;
    notifyListeners();
  }
}

