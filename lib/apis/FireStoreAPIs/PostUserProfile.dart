import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/models/user_model/post_creator.dart';

class PostUserProfile{
  static final _collectionRef = FirebaseAPIs.firestore.collection("appUser");

  static Future<PostCreator?> getPostCreator(String creatorId) async {
    final postCreator  = await _collectionRef
        .doc(creatorId)
        .get()
        .then((value) => value.data())
        .onError((error, stackTrace) => {"error": error, "stackTrace": stackTrace});

    if(postCreator?.containsKey("error") ?? true) {
      return null;
    }
    else {
      print("#pc: $postCreator");
      return PostCreator.fromJson(postCreator);
    }

  }

}