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

  static Future<bool> onLikeButtonTap(String postId, String userId, bool isLiked) async {
    if(isLiked){
      print("#isLike: ${isLiked}");
      return await FirebaseAPIs.rtdbRef.child("post/${postId}/like/${userId}").remove()
          .then((value) {
            print("#like R $postId");
            return true;
          })
          .onError((error, stackTrace) {
          print("#like R E $postId:${error}, ${stackTrace}");

        return false;
          });
    }
    else
    return await FirebaseAPIs.rtdbRef.child("post/${postId}/like/${userId}").set(true)
        .then((value) {
        print("#like A $postId");

    return true;
        })
        .onError((error, stackTrace) {
      print("#like A E $postId: ${error}, ${stackTrace}");

      return false;
        });
  }



}