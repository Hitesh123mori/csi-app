import 'package:csi_app/apis/googleAIPs/drive/DriveApi.dart';
import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:csi_app/utils/shimmer_effects/post_screen_shimmer_effect.dart';
import 'package:csi_app/utils/widgets/buttons/three_dot_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:like_button/like_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


import 'package:csi_app/apis/FireStoreAPIs/PostUserProfile.dart';
import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/apis/StorageAPIs/StorageAPI.dart';
import 'package:csi_app/models/post_model/image_model.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/models/user_model/post_creator.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/posting/comment_screens/comment_screens.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:csi_app/utils/widgets/posting/image_frame.dart';

import '../../../screens/home_screens/posting/add_post_screen.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({required this.post, Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showMore = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer2<PostProvider, AppUserProvider>(
      builder: (context, postProvider, appUserProvider, child) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: Material(
            elevation: 0.2,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.theme['secondaryColor'],
              ),
              width: mq.width,
              child: StreamBuilder(
                stream: PostUserProfile.getPostCreator(widget.post.createBy ?? "").asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    PostCreator postCreator = PostCreator.fromJson(snapshot.data);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPostHeader(context, postCreator, appUserProvider.user?.userID ?? "", postProvider),
                        if (widget.post.description != null) _buildDescription(),
                        if (widget.post.isThereImage) _buildImageSection(),
                        if (widget.post.pdfLink != "") _buildPdfSection(),
                        if (widget.post.poll != null) _buildPollSection(),
                        _buildReactionSection(appUserProvider, postProvider),
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return _buildErrorCard(context);
                  }
                  else {
                    return PostShimmerEffect();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
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

  Widget _buildPostHeader(BuildContext context, PostCreator postCreator, String appUserId, PostProvider postProvider) {

    return Card(
      elevation: 0,
      surfaceTintColor: AppColors.theme['secondaryColor'],
      color: AppColors.theme['secondaryColor'],
      child: ListTile(
        isThreeLine: true,
        title: Text(
          "${postCreator.name}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${postCreator.about ?? ""}",
              style: TextStyle(color: AppColors.theme['tertiaryColor']),
            ),
            Text(
              "${MyDateUtil.getMessageTime(context: context, time: widget.post.createTime ?? "0")}",
              style: TextStyle(color: AppColors.theme['tertiaryColor'], fontSize: 11),
            )
          ],
        ),
        leading: CircleAvatar(
          child: Text("${postCreator.name?[0].toUpperCase()}"),
          radius: 25,
          backgroundColor: AppColors.theme["secondaryBgColor"],
        ),
        contentPadding: EdgeInsets.only(left: 1),
        trailing: postCreator.userID == appUserId
            ? ThreeDotButton(
          options: ["Edit", "Delete"],
          onOptionSelected: (String option) async {
            print("#selOpt $option");

            switch (option) {
              case "edit":
                print("Editing");
                postProvider.post = widget.post;
                postProvider.forEdit = true;

                postProvider.notify();
                Navigator.push(context, RightToLeft(AddPostScreen()));
                break;
              case "delete":
                print("Deleting");

                if(widget.post.isThereImage ?? false)
                  StorageAPI.deletePostImg(widget.post.imageModelList);

                if(widget.post.pdfLink != "" && widget.post.pdfLink != null)
                  await DriveAPI.deleteFileFromDrive(widget.post.pdfLink);

                final res = await PostAPI.deletePost(widget.post.postId ?? "");

                if(res.containsKey("succ")){
                  HelperFunctions.showToast(res["succ"] ?? "");
                }
                else{
                  HelperFunctions.showToast("Error deleting post");
                  print("#del-post-error ${res["Error deleting post"]}");
                }

                break;
            }
          },
        )
            :Container(),
            // : ThreeDotButton(options: ["Report"], onOptionSelected: (String option) {print("#optSel $option");}),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showMore
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: HelperFunctions.buildContent(widget.post.description ?? ""),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: HelperFunctions.buildContent(HelperFunctions.truncateDescription(widget.post.description ?? "")),
        ),
        if (widget.post.description!.length > 100)
          TextButton(
            onPressed: () {
              setState(() {
                showMore = !showMore;
              });
            },
            child: Text(
              showMore ? 'Show Less' : 'Show More',
              style: TextStyle(color: AppColors.theme['tertiaryColor']),
            ),
          ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppColors.theme['secondaryBgColor'],
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(widget.post.attachmentName!, style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(
                      (widget.post.imageModelList?.length.toString() ?? "0") + " Images",
                      style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
              child: StreamBuilder(
                stream: StorageAPI.getImage(widget.post.postId).asStream(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    print("#hd: ${snap.data}");
                    widget.post.imageModelList = snap.data;
                    if (widget.post.imageModelList?.isEmpty ?? true) return PostShimmerEffect();
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: widget.post.imageModelList?.length,
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                            print("#imgUrl-home-screen: ${widget.post.imageModelList?[itemIndex]}");
                            return ImageFrame(imageModel: widget.post.imageModelList?[itemIndex] ?? ImageModel(), provider: null);
                          },
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            autoPlay: widget.post.images?.length != 1,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 1.0,
                            height: 500,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.post.imageModelList!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.theme['secondaryColor']
                                      : AppColors.theme['primaryColor']).withOpacity(_current == entry.key ? 0.9 : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator(color: AppColors.theme['primaryColor']);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.theme['secondaryBgColor'],
              borderRadius: BorderRadius.circular(2).copyWith(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Text(
                    widget.post.attachmentName ?? "Pdf",
                    style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Download", style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold)),
                      SizedBox(width: 3),
                      Icon(Icons.download_rounded, size: 20, color: AppColors.theme['tertiaryColor']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
          child: Container(
            height: 400,
            decoration: BoxDecoration(color: AppColors.theme['secondaryBgColor']),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfPdfViewer.network(
                pageLayoutMode: PdfPageLayoutMode.continuous,
                canShowScrollHead: false,
                pageSpacing: 2,
                canShowPageLoadingIndicator: false,
                widget.post.pdfLink!,
                key: _pdfViewerKey,
                scrollDirection: PdfScrollDirection.horizontal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPollSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: FlutterPolls(
          loadingWidget: SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(color: AppColors.theme['primaryColor'], strokeWidth: 2),
          ),
          leadingVotedProgessColor: AppColors.theme['secondaryBgColor'],
          votedBackgroundColor: AppColors.theme['secondaryColor'],
          votedProgressColor: AppColors.theme['secondaryBgColor'],
          pollOptionsSplashColor: AppColors.theme['secondaryBgColor'],
          createdBy: "",
          pollId: widget.post.poll?.pollId,
          onVoted: (PollOption pollOption, int newTotalVotes) async {
            bool success = await PostAPI.updateVote(widget.post.postId, pollOption.id.toString(), newTotalVotes + 1);
            return success;
          },
          pollTitle: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.post.poll!.question ?? "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          pollOptions: List<PollOption>.from(
            widget.post.poll!.options!.map(
                  (option) {
                var a = PollOption(
                  id: option.optionId,
                  title: Text(
                    option.title ?? "",
                    style: TextStyle(color: AppColors.theme['tertiaryColor']),
                  ),
                  votes: option.votes,
                );
                return a;
              },
            ),
          ),
          votedPercentageTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildReactionSection(AppUserProvider appUserProvider, PostProvider postProvider) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LikeButton(
            isLiked: widget.post.like?[appUserProvider.user?.userID] ?? false,
            likeCount: widget.post.like?.length ?? 0,
            likeBuilder: (bool isLiked) {
              return isLiked ? Icon(Icons.thumb_up, color: AppColors.theme["primaryColor"]) : Icon(Icons.thumb_up_alt_outlined, color: AppColors.theme["primaryColor"]);
            },
            bubblesColor: BubblesColor(
              dotPrimaryColor: AppColors.theme["primaryColor"],
              dotSecondaryColor: AppColors.theme["secondaryBgColor"],
            ),
            circleColor: CircleColor(start: AppColors.theme["primaryColor"], end: AppColors.theme["secondaryBgColor"]),
            onTap: (bool isLiked) async {
              bool successful = await PostAPI.onLikeButtonTap(widget.post.postId, appUserProvider.user?.userID ?? "noUser", isLiked);
              if (successful) {
                if (isLiked)
                  widget.post.like?.remove(appUserProvider.user?.userID ?? "noUser");
                else
                  widget.post.like?[appUserProvider.user?.userID ?? "noUser"] = true;
              }
              return successful ? !isLiked : isLiked;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              postProvider.post = widget.post;
              Navigator.push(context, LeftToRight(CommentScreen()));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.comment_rounded,
                    color: AppColors.theme["primaryColor"],
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${widget.post.comment?.length ?? 0}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

}

