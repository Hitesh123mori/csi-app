
import 'package:csi_app/models/event_model/event_model.dart';
import 'package:flutter/material.dart';

class CSIEventProvider extends ChangeNotifier{
  CSIEvent? event;
  bool forEditing = false;

  void notify(){
    notifyListeners();
  }
}