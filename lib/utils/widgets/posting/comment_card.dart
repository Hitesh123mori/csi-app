import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/models/user_model/post_creator.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:csi_app/utils/shimmer_effects/comment_screen_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/shared.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../apis/FireStoreAPIs/PostUserProfile.dart';
import '../../../main.dart';
import '../../../models/post_model/post.dart';

class CommentCard extends StatefulWidget {
  final PostComment postComment;
  final String postId;
  final String postCreatorId;
  const CommentCard({super.key, required this.postComment, required this.postCreatorId, required this.postId});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isSuccLike = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(builder: (context, appUserProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: mq.width * 1,
            decoration: BoxDecoration(
              color: AppColors.theme['secondaryColor'],
              borderRadius: BorderRadius.circular(10),
            ),
            child: StreamBuilder(
              stream: PostUserProfile.getPostCreator(widget.postComment.userId ?? "").asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  PostCreator commentCreator = PostCreator.fromJson(snapshot.data);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 8),
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.theme['secondaryBgColor'],
                          child: Center(
                            child: Text(
                              HelperFunctions.getInitials(commentCreator.name ?? ""),
                              style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        title: Text(
                          commentCreator.name ?? "",
                          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          commentCreator.about ?? "",
                          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.w500),
                        ),
                        trailing: Container(
                          width: 100,
                          child: widget.postComment.userId == widget.postCreatorId
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.theme['primaryColor'],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      child: Text(
                                        "Creator",
                                        style: TextStyle(
                                          color: AppColors.theme['secondaryColor'],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Text(
                          widget.postComment.message ?? "",
                          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LikeButton(
                                likeCount: widget.postComment.like?.length ?? 0,
                                isLiked: widget.postComment.like?[appUserProvider.user?.userID] ?? false,
                                likeBuilder: (bool isLiked) {
                                  return isLiked
                                      ? Icon(
                                          Icons.thumb_up,
                                          color: AppColors.theme["primaryColor"],
                                        )
                                      : Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: AppColors.theme["primaryColor"],
                                        );
                                },
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: AppColors.theme["primaryColor"],
                                  dotSecondaryColor: AppColors.theme["secondaryBgColor"],
                                ),
                                circleColor: CircleColor(start: AppColors.theme["primaryColor"], end: AppColors.theme["secondaryBgColor"]),
                                onTap: (bool isLiked) async {
                                  PostAPI.onCommentLikeButtonTap(
                                          widget.postId, widget.postComment.commentId ?? "", appUserProvider.user?.userID ?? "", isLiked)
                                      .then((value) {
                                    _isSuccLike = true;

                                    if (isLiked)
                                      widget.postComment.like?.remove(appUserProvider.user?.userID ?? "noUser");
                                    else {
                                      if (widget.postComment.like == null) widget.postComment.like = {};
                                      widget.postComment.like?[appUserProvider.user?.userID ?? "noUser"] = true;
                                    }

                                    setState(() {});
                                  }).onError((error, stackTrace) {
                                    _isSuccLike = false;
                                  });

                                  return _isSuccLike ? !isLiked : isLiked;
                                },
                              ),
                            ),
                            Text(
                              MyDateUtil.getMessageTime(
                                  context: context,
                                  time: widget.postComment.createdTime ?? ""), // Use the null-aware operator (??) to provide a fallback value
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return _buildErrorCard(context);
                } else {
                  return CommentShimmerEffect();
                }
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildErrorCard(BuildContext context) {
    return Card(
      elevation: 0,
      surfaceTintColor: AppColors.theme['secondaryColor'],
      color: AppColors.theme['secondaryColor'],
      child: ListTile(
        title: Text(
          "Error Occurred",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "There was an error fetching data",
          style: TextStyle(color: AppColors.theme['tertiaryColor']),
        ),
        leading: CircleAvatar(
          child: Icon(Icons.error, color: Colors.white),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
