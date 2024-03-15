import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csi_app/models/user_model/AppUser.dart';
import 'package:http/http.dart';

import '../FireStoreAPIs/UserProfileAPI.dart';
import '../FirebaseAPIs.dart';

class NotificationApi {
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
  static Future<void> sendPushNotification(
      AppUser toUser, String msg, AppUser fromUser) async {
    print("done");
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
