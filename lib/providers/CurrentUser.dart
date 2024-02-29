import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:csi_app/screens/auth_sceens/.dart';

class AppUserProvider extends ChangeNotifier{
  String? name;
  String? userType;
  String? gender;

  void edit(){
    name = name ?? ""+" 1";
    notifyListeners();
  }

  Future<void> create(String name) async {
    this.name = name;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("authToken", this.name!);
    notifyListeners();
  }

  // Future<bool> isAuthenticUser() async {
  //   return false
  // }


  void logOut(context) async {
    this.name = null;

    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("authToken");

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Auth()));
    notifyListeners();
  }

}