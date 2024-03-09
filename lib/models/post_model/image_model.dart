import 'package:csi_app/apis/FirebaseAPIs.dart';

class ImageModel {
  ImageModel({
    this.fullPath,
    this.uri,
    this.callback
  });

  ImageModel.fromJson(dynamic json) {
    fullPath = json['fullPath'];
    uri = json['uri'];
  }
  String? fullPath;
  Future<String>? uri;
  void Function()? callback;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullPath'] = fullPath;
    map['uri'] = uri;
    return map;
  }

  Future<void> delete()async {
    if(fullPath == null) return;
    FirebaseAPIs.storage.child(fullPath!).delete();
    callback!;
  }
}