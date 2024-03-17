import 'package:csi_app/apis/FirebaseAPIs.dart';

/// id : ""
/// message : ""
/// from_user_id : ""
/// to_user_id : ""
/// time : ""

class Announcement {
  Announcement({
      this.message, 
      this.fromUserId, 
      this.toUserId, 
      this.time,})
  {
      this.id = FirebaseAPIs.uuid.v1();
  }

  Announcement.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    time = json['time'];
  }

  String? id;
  String? message;
  String? fromUserId;
  String? toUserId;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['from_user_id'] = fromUserId;
    map['to_user_id'] = toUserId;
    map['time'] = time;
    return map;
  }

  int compareTo(Announcement other){
    int timeA = int.tryParse(this.time?? "0") ?? 0;
    int timeB = int.tryParse(other.time?? "0") ?? 0;
    return timeA.compareTo(timeB);
  }

}