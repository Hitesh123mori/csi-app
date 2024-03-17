import 'dart:developer';

import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/post_model/image_model.dart';

class StorageAPI {
  static final _postFolder = FirebaseAPIs.storage.child("post");

  static Future uploadPostImg(String postId, var img) async {
    final imgRef = _postFolder.child("${postId}/${FirebaseAPIs.uuid.v1()}");

    await imgRef.putData(img).then((p0) {
      log("#upload: ${p0.toString()}");
      return null;
    }).onError((error, stackTrace) {
      log("#upload E: ${error}, \n $stackTrace");
      return null;
    });
  }

  static Future deletePostImg(List<ImageModel>? imageModelList) async {
    imageModelList?.forEach((element) async {
      await element.delete();
    });
  }


  static Future<dynamic> getImage(String postId)async {
    final imgRef = _postFolder.child("${postId.toString()}");

    return imgRef.list().then((value) {
      List<Reference> refs = value.items;

      log("#res: ${refs.map((e) => e.name)}");
      log("#");
      return refs.map((e) => ImageModel(fullPath: e.fullPath, uri: e.getDownloadURL(), callback: () => (){})).toList();
    });

  }
}
