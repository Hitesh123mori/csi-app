import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/models/post_model/image_model.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:image_picker/image_picker.dart';

/// postId : ""
/// createBy : ""
/// createTime : ""
/// likeCount : 21
/// description : ""
/// attachmentName : ""
/// pdfLink : ""
/// isThereImage : true
/// poll : {"pollId":"","question":"","endTime":"","options":[{"optionId":"oid-1","title":"","votes":12}]}
/// comment : [{"commentId":"cid-1","message":"","likecount":12,"userId":"","createdTime":""}]

class Post {
  Post({
    this.createBy,
    this.createTime,
    this.like,
    this.description,
    this.attachmentName,
    this.pdfLink,
    this.isThereImage = false,
    this.poll,
    this.comment,
  }) {
    this.postId = FirebaseAPIs.uuid.v1();
    // this.like = {};
  }

  Post.fromJson(dynamic json) {
    postId = json['postId'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    print("#like = : ${json['like']}");
    like = json['like'];
    description = HelperFunctions.base64ToString(json['description']??"");
    attachmentName = json['attachmentName'];
    pdfLink = HelperFunctions.base64ToString(json['pdfLink']??"");
    isThereImage = json['isThereImage'];
    poll = json['poll'] != null
        ? Poll.fromJson(json['poll']) : null;
    print("#poll: ${poll}");
    if (json['comment'] != null) {
      comment = [];
      json['comment'].forEach((k, v) {
        comment?.add(PostComment.fromJson(v));
      });
    }
  }
  late String postId;
  String? createBy;
  String? createTime;
  String? description;
  String? attachmentName;
  String? pdfLink;
  late bool isThereImage;
  Poll? poll;
  Map<dynamic, dynamic>? like;
  List<PostComment>? comment;
  List<XFile>? images;
  List<ImageModel>? imageModelList;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['postId'] = postId;
    map['createBy'] = createBy;
    map['createTime'] = createTime;
    map['like'] = like;
    map['description'] = HelperFunctions.stringToBase64(description??"");
    map['attachmentName'] = attachmentName;
    map['pdfLink'] = HelperFunctions.stringToBase64(pdfLink??"");
    map['isThereImage'] = isThereImage;
    if (poll != null) {
      map['poll'] = poll?.toJson();
    }
    if (comment != null) {
      map['comment'] = comment?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// commentId : "cid-1"
/// message : ""
/// likecount : 12
/// userId : ""
/// createdTime : ""

class PostComment {
  PostComment({
    this.message,
    this.like,
    this.userId,
    this.createdTime,}){
    this.commentId = FirebaseAPIs.uuid.v1();
  }

  PostComment.fromJson(dynamic json) {
    commentId = json['commentId'];
    message = json['message'];
    like = json['like'];
    userId = json['userId'];
    createdTime = json['createdTime'];
  }
  String? commentId;
  String? message;
  Map<String, dynamic>? like;
  String? userId;
  String? createdTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = commentId;
    map['message'] = message;
    map['like'] = like;
    map['userId'] = userId;
    map['createdTime'] = createdTime;
    return map;
  }

}

/// pollId : ""
/// question : ""
/// endTime : ""
/// options : [{"optionId":"oid-1","title":"","votes":12}]

class Poll {
  Poll({
    this.question,
    this.endTime,
    this.options,}){
    this.pollId = FirebaseAPIs.uuid.v1();
  }

  Poll.fromJson(dynamic json) {
    pollId = json['pollId'];
    question = json['question'];
    endTime = json['endTime'];

    if (json['options'] != null) {
      options = [];
      json['options'].forEach((k, v) {
        print("#option: $k, $v");
        options?.add(Options.fromJson(v));
      });
    }
  }
  String? pollId;
  String? question;
  String? endTime;
  List<Options>? options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pollId'] = pollId;
    map['question'] = question;
    map['endTime'] = endTime;
    // print("#opt? $options");
    if (options != null) {
      print("#if");
      map['options'] = {}; // Initialize options as an empty map
      options?.forEach((v) { // Iterate over each element in options
        Map<String, dynamic> m = v.toJson(); // Convert each element to a map
        map['options'][m['optionId']] = m; // Assign each element to map['options']
      });
      print("#opt ${map['options']}"); // Print the contents of map['options']

    }
    return map;
  }

}

/// optionId : "oid-1"
/// title : ""
/// votes : 12

class Options {
  Options({
    this.title,
    this.votes = 0,}){
    this.optionId = FirebaseAPIs.uuid.v1();
  }

  Options.fromJson(dynamic json) {
    print("#option-option: $json");
    optionId = json['optionId'];
    title = json['title'];
    votes = json['votes'];
  }
  String? optionId;
  String? title;
  late int votes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionId'] = optionId;
    map['title'] = title;
    map['votes'] = votes;
    return map;
  }
}