import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../models/post_model/post.dart';

class CommentCard extends StatefulWidget {
  final PostComment cmnt;
  const CommentCard({super.key, required this.cmnt});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.theme['secondaryBgColor'],
                    child: Center(
                        child: Text(
                      HelperFunctions.getInitials(appUserProvider.user?.name ?? ""),
                      style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                    )),
                  ),
                  title: Text(
                    appUserProvider.user?.name ?? "",
                    style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    appUserProvider.user?.about ?? "",
                    style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
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
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    widget.cmnt!.message ?? "",
                    style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //todo: fix like button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LikeButton(
                          likeCount: 23,
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
                          onTap: (bool isLiked) async {},
                        ),
                      ),

                      Text(MyDateUtil.getMessageTime(context: context, time: widget.cmnt.createdTime! ?? "")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
