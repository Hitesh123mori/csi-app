import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/models/post_model/post.dart';

class PostAPI {

  static Future<String> postUpload(Post post) async {
    print("#post: ${post.toJson()}");

      return FirebaseAPIs.rtdbRef.child("post/${post.postId.toString()}").set(post.toJson())
          .then((value) {
            return "Posted";
          })
          .onError((error, stackTrace) {
            print("#Error-post: $error \n $stackTrace");
            return "Error";
          });
  }

  static Future updateVote(String postId, String optionId, int newTotalVotes) async {
    return await FirebaseAPIs.rtdbRef.child("post/$postId/poll/options/$optionId/votes").set(newTotalVotes)
    .then((value) {
      print("#nv $newTotalVotes");
      return true;
    })
      .onError((error, stackTrace) {
        print("nv E: $error, \n $stackTrace");
        return false;
      })
    ;

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

  static Future<Map<String, String>> addComment(String postId, PostComment postComment)async {
    return await FirebaseAPIs.rtdbRef.child("post/$postId/comment/${postComment.commentId}").set(postComment.toJson())
    .then((value) {
      print("#com-s");
      return {'success': 'Comment posted'};
    })
    .onError((error, stackTrace) {
      print("#com-e: $error \n $stackTrace");
      return {"error": '$error \n $stackTrace'};
    });
  }

  static Future<Map<String, String>> deletePost(String postId) async {
    return await FirebaseAPIs.rtdbRef.child("post/$postId").remove()
        .then((value) => {"succ": "Post deleted"})
        .onError((error, stackTrace) => {"Error deleting post": "$error, \n $stackTrace"});
  }
}