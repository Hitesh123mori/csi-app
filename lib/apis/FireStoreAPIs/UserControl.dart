import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/apis/FirebaseAPIs.dart';

class UserControl {
  static final _userColRef = FirebaseAPIs.firestore.collection("appUser");

  static Future<bool> makeAdmin(String? userId) async {
    if (userId == null) return false;
    return await _userColRef.doc("$userId").update({"is_admin": true}).then((value) {
      return true;
    }).onError((error, stackTrace) {
      print("#makeAdmin-error : $error \n $stackTrace");
      return false;
    });
  }

  static Future<bool> makeSuperuser(String? userId, String? currentUser) async {
    if (userId == null || currentUser == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        await _userColRef.doc("$userId").update({"is_superuser": true});
        await _userColRef.doc("$currentUser").update({"is_superuser": false});
        return true;
      });
      
    } catch (e) {
      print("#promotion-tf :superuser $e");
      return false;
    }
  }

  static Future<bool> removeAdmin(String? userId) async {
    if (userId == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        await _userColRef.doc("$userId").update({"is_admin": false});
        return true;          
      });
    } catch (e) {
      print("#demotion-tf :admin :$e");
      return false;
    }
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAdmins() {
    return _userColRef.where("is_admin", isEqualTo: true).orderBy("name").get().asStream();
  }
}
