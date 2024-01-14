import 'package:flutter/widgets.dart';

class BottomNavigationProvider extends ChangeNotifier {
  Map<String, bool> homeScreenOptions = {
    "isHomeTab": true,
    "isUpcomeEventTab": false,
    "isEventCalTab": false,
    "isAskTab": false,
  };

  String current = "isHomeTab";

  void updateCurrent(String option) {
    homeScreenOptions[current] = false;
    current = option;
    homeScreenOptions[current] = true;
    notifyListeners();
  }
}

