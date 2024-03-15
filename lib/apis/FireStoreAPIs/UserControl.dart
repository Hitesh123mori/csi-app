import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/apis/FirebaseAPIs.dart';

class UserControl {
  static final _adminColRef = FirebaseAPIs.firestore.collection("admin");
  static final _superuserColRef = FirebaseAPIs.firestore.collection("superuser");
  static final _userColRef = FirebaseAPIs.firestore.collection("appUser");

  static Future<bool> makeAdmin(String? userId) async {
    if (userId == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        return await _userColRef.doc("$userId").update({"is_admin": true})
            .then((value) async {
          DocumentSnapshot sourceDocSnapshot = await _userColRef.doc(userId).get();
          if(sourceDocSnapshot.exists){
            return _adminColRef.doc(userId).set(sourceDocSnapshot.data() as Map<String, dynamic>)
                .then((value) {
              print("#promoted to admin");
              return true;
            }).onError((error, stackTrace) {
              print("#promotion-e :admin :$error, \n $stackTrace");
              return false;
            });
          }
          else return false;
        })
            .onError((error, stackTrace) {
          print("#promotion-e :admin :$error, \n $stackTrace");
          return false;
        });
      });
    }
    catch (e) {
      print("#promotion-tf :admin :$e");
      return false;
    }
  }

  static Future<bool> makeSuperuser(String? userId) async {
    if (userId == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        return await _userColRef.doc("$userId").update({"is_superuser": true})
            .then((value) async {
          DocumentSnapshot sourceDocSnapshot = await _userColRef.doc(userId).get();
          if(sourceDocSnapshot.exists){
            return _superuserColRef.doc(userId).set(sourceDocSnapshot.data() as Map<String, dynamic>)
                .then((value) {
              print("#promoted to superuser");
              return true;
            }).onError((error, stackTrace) {
              print("#promotion-e :superuser : $error, \n $stackTrace");
              return false;
            });
          }
          else return false;
        })
            .onError((error, stackTrace) {
          print("#promotion-e :superuser : $error, \n $stackTrace");
          return false;
        });
      });
    }
    catch (e) {
      print("#promotion-tf :superuser $e");
      return false;
    }

  }

  static Future<bool> removeAdmin(String? userId) async {
    if (userId == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        return await _userColRef.doc("$userId").update({"is_admin": false})
            .then((value) async {
          return await _adminColRef.doc(userId).delete()
              .then((value) {
            print("#demoteted");
            return true;
          })
              .onError((error, stackTrace) {
            print("#demotion-e :admin :$error \n $stackTrace");
            return false;
          });
        })
            .onError((error, stackTrace) {
          print("#demotion-e :admin :$error \n $stackTrace");
          return false;
        });
      });
    }

    catch (e) {
      print("#demotion-tf :admin :$e");
      return false;
    }

  }

  static Future<bool> removeSuperuser(String? userId) async {
    if (userId == null) return false;

    try {
      return await FirebaseAPIs.firestore.runTransaction((transaction) async {
        return await _userColRef.doc("$userId").update({"is_superuser": false})
            .then((value) async {
          return await _superuserColRef.doc(userId).delete()
              .then((value) {
            print("#demoteted");
            return true;
          })
              .onError((error, stackTrace) {
            print("#demotion-e :superuser :$error \n $stackTrace");
            return false;
          });
        })
            .onError((error, stackTrace) {
          print("#demotion-e :superuser :$error \n $stackTrace");
          return false;
        });
      });
    }

    catch (e) {
      print("#demotion-tf :superuser :$e");
      return false;
    }

  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAdmins()  {
    return _adminColRef.snapshots();
  }


}