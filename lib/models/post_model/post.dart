import 'package:csi_app/models/post_model/poll_model.dart';

class Post {
  String? fromid;
  bool? isAnyAttachment;
  bool? isDescription;
  bool? isPdfPost;
  int? likecount;
  int? commentcount;
  String? posttime;
  String? description;
  String? attachmentname;
  List<String>? images;
  String? pdflink;
  bool? isPoll;
  Poll? poll;

  Post({
    this.fromid,
    this.isDescription,
    this.isAnyAttachment,
    this.isPdfPost,
    this.likecount,
    this.commentcount,
    this.posttime,
    this.description,
    this.pdflink,
    this.poll,
    this.attachmentname,
    this.isPoll,
    this.images,
  });

  Post.fromJson(Map<String, dynamic> json)
      : fromid = json['fromid'] ?? '',
        isAnyAttachment = json['isAnyAttachment'] ?? false,
        isDescription = json['isDescription'] ?? false,
        isPoll = json['isPoll'] ?? false,
        isPdfPost = json['isPdfPost'] ?? false,
        likecount = json['likecount'] ?? 0,
        commentcount = json['commentcount'] ?? 0,
        description = json['description'] ?? '',
        attachmentname = json['attachmentname'] ?? '',
        posttime = json['posttime'] ?? '',
        images = json['images'] != null ? List<String>.from(json['images']) : null,
        pdflink = json['pdflink'] ?? '',
        poll = json['poll'] != null ? Poll.fromJson(json['poll']) : null;

  Map<String, dynamic> toJson() {
    return {
      'fromid': fromid,
      'isAnyAttachment': isAnyAttachment,
      'isDescription': isDescription,
      'isPoll': isPoll,
      'isPdfPost': isPdfPost,
      'likecount': likecount,
      'commentcount': commentcount,
      'description': description,
      'attachmentname': attachmentname,
      'posttime': posttime,
      'images': images,
      'pdflink': pdflink,
      'poll': poll?.toJson(),
    };
  }
}
