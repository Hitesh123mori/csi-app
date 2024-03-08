import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:firebase_database/firebase_database.dart';

class PostAPI {
  static Future<String> postUpload(Post post) async {
      return FirebaseAPIs.rtdbRef.child("post/${post.postId.toString()}").set(post.toJson())
          .then((value) {
            return "Posted";
          })
          .onError((error, stackTrace) {
            print("#Error-post: $error \n $stackTrace");
            return "Error";
          });
  }


  static Future updateVote() async {

  }



}