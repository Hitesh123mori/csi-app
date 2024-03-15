import 'package:csi_app/apis/FireStoreAPIs/UserProfileAPI.dart';
import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/models/user_model/AppUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apis/notification_apis/notifications_api.dart';

class AppUserProvider extends ChangeNotifier{
  AppUser? user;

  void notify(){
    notifyListeners();
  }

  Future initUser() async {
    String? uid = FirebaseAPIs.auth.currentUser?.uid;
    print("#authId: $uid");
    if(uid != null){
      user = AppUser.fromJson(await UserProfile.getUser(uid));
      await NotificationApi.getFirebaseMessagingToken(uid) ;
    }
    notifyListeners();
    print("#initUser complete");
  }

  Future logOut() async {
    await FirebaseAPIs.auth.signOut();
    user  = null ;
    notifyListeners();
  }

}