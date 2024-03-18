import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/notification_model/Announcement.dart';
import '../../models/user_model/AppUser.dart';
import '../FireStoreAPIs/UserProfileAPI.dart';
import '../FirebaseAPIs.dart';

class NotificationApi {
  static final _notificationDocRef = FirebaseAPIs.firestore.collection("notification").doc("all");
  static final _privateNotificationColRef = _notificationDocRef.collection("private");
  static final _publicNotificationColRef = _notificationDocRef.collection("public");

  static Future<void> storeNotification(Announcement announcement, bool isPrivate) async {
    if (isPrivate) {
      await _privateNotificationColRef.doc(announcement.id).set(announcement.toJson());
    } else {
      await _publicNotificationColRef.doc(announcement.id).set(announcement.toJson());
    }
  }

  static Future<List<Announcement>> getNotification(String userId) async {
    List<Announcement> notifications = [];
    log("#getting notifications .. ");

    try {
      final res = await _publicNotificationColRef.get();
      res.docs.forEach((element) {
        notifications.add(Announcement.fromJson(element.data()));
      });

      final res2 = await _privateNotificationColRef.where("to_user_id", isEqualTo: userId).get();
      res2.docs.forEach((element) {
        notifications.add(Announcement.fromJson(element.data()));
      });

      notifications.sort((a, b) => b.compareTo(a));
    } catch (error) {
      log('Error getting notifications: $error');
    }

    return notifications;
  }

  static Future<void> getFirebaseMessagingToken(String uid) async {
    try {
      await FirebaseAPIs.fmessaging.requestPermission();

      await FirebaseAPIs.fmessaging.getToken().then((t) async {
        if (t != null) {
          Map<String, dynamic> fields = {"notification_token": t};
          await UserProfile.updateUserProfile(uid, fields);
          log('Push Token: $t');
        }
      });
    } catch (error) {
      log('Error getting Firebase Messaging token: $error');
    }
  }

  static Future<List<String>> getAllUserTokens() async {
    List<String> userTokens = [];

    try {
      CollectionReference usersRef = FirebaseFirestore.instance.collection('appUser');
      QuerySnapshot usersSnapshot = await usersRef.get();

      usersSnapshot.docs.forEach((userDoc) {
        String? token = (userDoc.data() as Map<String, dynamic>?)?['notification_token'];
        if (token != null && token.isNotEmpty) {
          userTokens.add(token);
        }
      });
    } catch (error) {
      log('Error fetching user tokens: $error');
    }

    return userTokens;
  }

  static Future<void> sendMassNotificationToAllUsers(String message) async {
    try {
      List<String> allUserTokens = await getAllUserTokens();
      if (allUserTokens.isEmpty) {
        log('No user tokens found');
        return;
      }

      var requestBody = jsonEncode({
        "registration_ids": allUserTokens,
        "notification": {
          "title": "Announcement",
          "body": message,
        },
      });

      var response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
          'Bearer AAAAFKg5U60:APA91bF00s06GHKatVH7YUNFfKQxc-Z-jQKv29pd348QPJR9BDXf8RjWV_1pAoD3jiQL3IR3W8S86769atahmORr35Nk6SIfr974qB4LT9zZrBQaBWE1wrPklxwI16_gbpUWHi0wyFd3'
        },
        body: requestBody,
      );

      log('Send mass notification response status: ${response.statusCode}');
      log('Send mass notification response body: ${response.body}');
    } catch (error) {
      log('Error sending mass notification: $error');
    }
  }



  static Future<void> sendPushNotification(AppUser toUser, String msg,
      AppUser fromUser) async {
    try {
      final body = {
        "to": toUser.notificationToken,
        "notification": {"title": fromUser.name, "body": msg},
        "data": {"some_data": "user id : ${fromUser.userID}"},
      };

      var res = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
          'Bearer AAAAFKg5U60:APA91bF00s06GHKatVH7YUNFfKQxc-Z-jQKv29pd348QPJR9BDXf8RjWV_1pAoD3jiQL3IR3W8S86769atahmORr35Nk6SIfr974qB4LT9zZrBQaBWE1wrPklxwI16_gbpUWHi0wyFd3'
        },
        body: jsonEncode(body),
      );
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

}
