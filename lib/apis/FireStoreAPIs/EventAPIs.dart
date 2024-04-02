import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/apis/FirebaseAPIs.dart';


import '../../models/event_model/event_model.dart';

class EventAPIs {
  static final _collectionRef = FirebaseAPIs.firestore.collection("events");

  static Future<dynamic> addEvent(CSIEvent event) async {
    print("#ee");
    return await _collectionRef
        .doc(event.eventId)
        .set(event.toJson())
        .onError((error, stackTrace) => error.toString());

  }

  static Future<dynamic> updateEvent(CSIEvent event) async {

    return await _collectionRef
        .doc(event.eventId)
        .set(event.toJson())
        .onError((error, stackTrace) => error.toString());

  }

  static Future<dynamic> deleteEvent(String eventId) async {
    return await _collectionRef.doc(eventId).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllEvents()  {
    return _collectionRef.snapshots();
  }
}
