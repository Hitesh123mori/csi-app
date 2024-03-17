import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csi_app/models/notification_model/Announcement.dart';
import 'package:csi_app/models/user_model/AppUser.dart';
import 'package:http/http.dart';

import '../FireStoreAPIs/UserProfileAPI.dart';
import '../FirebaseAPIs.dart';

class NotificationApi {

  static final _notificationDocRef  = FirebaseAPIs.firestore.collection("notification").doc("all");
  static final _privateNotificationColRef = _notificationDocRef.collection("private");
  static final _publicNotificationColRef = _notificationDocRef.collection("public");


  static Future storeNotification (Announcement announcement, bool isPrivate) async {
    if(isPrivate){
      _privateNotificationColRef.doc(announcement.id).set(announcement.toJson());
    }
    else{
      _publicNotificationColRef.doc(announcement.id).set(announcement.toJson());
    }
  }

  static Future getNotification (String userId) async {
    List<Announcement> notifications = [];
    print("#getting notifications .. ");

    final res = await _publicNotificationColRef.get();
    print("${res.docs}");
    res.docs.forEach((element) {
      print("${element.data()}");
      notifications.add(Announcement.fromJson(element.data()));
    });

    final res2 = await _privateNotificationColRef.where("to_user_id", isEqualTo: userId).get();
    print("${res2.docs}");
    res2.docs.forEach((element) {
      print("${element.data()}");
      notifications.add(Announcement.fromJson(element.data()));
    });


    notifications.sort((a, b) => b.compareTo(a));

    return notifications;
  }


  // get notification token
  static Future<void> getFirebaseMessagingToken(String uid) async {
    await FirebaseAPIs.fmessaging.requestPermission();

    await FirebaseAPIs.fmessaging.getToken().then((t) async {
      if (t != null) {
        Map<String, dynamic> fields = {
          "notification_token": t,
        };
        await UserProfile.updateUserProfile(uid, fields);
        log('Push Token: $t');
      }
    });
  }

  // send notificaition function
  static Future<void> sendPushNotification(AppUser toUser, String msg, AppUser fromUser) async {
    try {
      final body = {
        "to": toUser.notificationToken,
        "notification": {
          "title": fromUser.name,
          "body": msg,
          // "android_channel_id": "Chats",
        },
        "data": {
          "some_data": "user id : ${fromUser.userID}",
        },
      };

      // Announcement announcement = Announcement(message: "$msg + private", fromUserId: fromUser.userID, toUserId: toUser.userID, time: DateTime.now().millisecondsSinceEpoch.toString());
      // Announcement announcement2 = Announcement(message: "$msg + public", fromUserId: fromUser.userID, toUserId: toUser.userID, time: DateTime.now().millisecondsSinceEpoch.toString());
      //
      // await storeNotification(announcement, true);
      // await storeNotification(announcement2, false);

      // await getNotification(fromUser.userID ?? "");


      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'AAAAFKg5U60:APA91bF00s06GHKatVH7YUNFfKQxc-Z-jQKv29pd348QPJR9BDXf8RjWV_1pAoD3jiQL3IR3W8S86769atahmORr35Nk6SIfr974qB4LT9zZrBQaBWE1wrPklxwI16_gbpUWHi0wyFd3'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}
