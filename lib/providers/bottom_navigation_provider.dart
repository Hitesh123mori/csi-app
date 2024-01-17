import 'package:flutter/widgets.dart';

class BottomNavigationProvider extends ChangeNotifier {
  Map<String, bool> homeScreenOptions = {
    "Home": true,
    "Notifications": false,
    "Calendar": false,
    "Doubt Section": false,
    "More Options" :false,
  };

  String current = "Home";

  void updateCurrent(String option) {
    homeScreenOptions[current] = false;
    current = option;
    homeScreenOptions[current] = true;
    notifyListeners();
  }
}

