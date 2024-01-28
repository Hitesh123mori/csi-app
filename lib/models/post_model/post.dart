import 'package:csi_app/models/post_model/poll_model.dart';

class Post {
  final String fromid;
  final bool isAnyAttachment;
  final bool isDescription;
  final bool isPdfPost;
  final int likecount;
  final int clapcount;
  final int heartcount;
  final int funnycount;
  final int commentcount;
  final String posttime;
  final String? description;
  final String? attachmentname;
  final List<String>? images;
  final String? pdflink;
  final bool isPoll;
  final Poll? poll;

  Post({
    required this.fromid,
    required this.isDescription,
    required this.isAnyAttachment,
    required this.isPdfPost,
    required this.likecount,
    required this.clapcount,
    required this.heartcount,
    required this.funnycount,
    required this.commentcount,
    required this.posttime,
    this.description,
    this.pdflink,
    this.poll,
    this.attachmentname,
    required this.isPoll,
    this.images,
  });

  Post.fromJson(Map<String, dynamic> json)
      : fromid = json['fromid'] ?? '',
        isAnyAttachment = json['isAnyAttachment'] ?? false,
        isDescription = json['isDescription'] ?? false,
        isPoll = json['isPoll'] ?? false,
        isPdfPost = json['isPdfPost'] ?? false,
        likecount = json['likecount'] ?? 0,
        clapcount = json['clapcount'] ?? 0,
        heartcount = json['heartcount'] ?? 0,
        funnycount = json['funnycount'] ?? 0,
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
      'clapcount': clapcount,
      'heartcount': heartcount,
      'funnycount': funnycount,
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
