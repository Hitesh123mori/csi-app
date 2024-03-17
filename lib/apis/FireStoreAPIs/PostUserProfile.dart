import 'dart:developer';

import 'package:csi_app/apis/FirebaseAPIs.dart';

class PostUserProfile{
  static final _collectionRef = FirebaseAPIs.firestore.collection("appUser");

  static Future<dynamic> getPostCreator(String creatorId) async {
    final postCreator  = await _collectionRef
        .doc(creatorId)
        .get()
        .then((value) => value.data())
        .onError((error, stackTrace) => {"error": error, "stackTrace": stackTrace});

    if(postCreator?.containsKey("error") ?? true) {
      throw Exception(postCreator);
    }
    else {
      log("#pc: $postCreator");
      return postCreator;
    }

  }

}