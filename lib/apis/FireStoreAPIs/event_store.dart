import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/apis/FirebaseAPIs.dart';


import '../../models/event_model/event_model.dart';

class EventStore {
  static final _collectionRef = FirebaseAPIs.firestore.collection("events");

  static Future<dynamic> storeEvent(
      String name,
      String url,
      String startTime,
      String endTime,
      String startDate,
      String endDate,
      String notifyHours) async {

    CSIEvent csiEvent = CSIEvent(
        eventName: name,
        registerUrl: url,
        startTime: startTime,
        participantsCount: '',
        endTime: endTime,
        notificationDuration: notifyHours,
        startDate: startDate,
        endDate: endDate,
    );

    return await _collectionRef
        .doc()
        .set(csiEvent.toJson())
        .onError((error, stackTrace) => error.toString());
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllEvents()  {
    return _collectionRef.snapshots();
  }
}
