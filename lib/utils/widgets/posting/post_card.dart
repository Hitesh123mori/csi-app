import 'package:carousel_slider/carousel_slider.dart';
import 'package:csi_app/apis/StorageAPIs/StorageAPI.dart';
import 'package:csi_app/main.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/posting/comment_screens/CommentScreen.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({required this.post, super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // for description
  bool showMore = false;

  // for carousel slider
  List<String> imageUrls = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.post.isThereImage) {
      imageUrls = StorageAPI.getImg(widget.post.postId);
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer2<PostProvider, AppUserProvider>(
      builder: (context, postProvider, appUserProvider, child){
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
                child: Column(
                  children: [
                    // post header
                    Card(
                      elevation: 0,
                      surfaceTintColor: AppColors.theme['secondaryColor'],
                      color: AppColors.theme['secondaryColor'],
                      // color: AppColors.theme['secondaryBgColor'],
                      child: ListTile(
                        title: Text(
                          "Computer Society of India",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Nirma University Club",
                          style: TextStyle(color: AppColors.theme['tertiaryColor']),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/csi_logo.png"),
                          radius: 25,
                        ),
                        contentPadding: EdgeInsets.only(left: 1),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert_outlined),
                        ),
                      ),
                    ),

                    // display description if present
                    if (widget.post.description != null)
                      Column(
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
                      ),

                    if (widget.post.isThereImage)
                      Padding(
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
                                      child: Text(widget.post.attachmentName!,
                                          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                      child: Text(
                                        imageUrls.length.toString() + " Images",
                                        style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CarouselSlider.builder(
                                      itemCount: imageUrls.length,
                                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Image.asset(imageUrls[itemIndex]),
                                      options: CarouselOptions(
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: imageUrls.length != 1,
                                          enlargeCenterPage: true,
                                          viewportFraction: 1,
                                          aspectRatio: 1.0,
                                          initialPage: 0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          }),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: imageUrls.asMap().entries.map((entry) {
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
                                                  : AppColors.theme['primaryColor'])
                                                  .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (widget.post.pdfLink != "")
                      Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          bottom: 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.theme['secondaryBgColor'],
                              borderRadius: BorderRadius.circular(2).copyWith(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              )),
                          height: 40,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Text(widget.post.attachmentName ?? "",
                                  style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Download", style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.download_rounded,
                                    size: 20,
                                    color: AppColors.theme['tertiaryColor'],
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),

                    if (widget.post.pdfLink != "")
                      Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          top: 0,
                        ),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: AppColors.theme['secondaryBgColor'],
                          ),
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

                    if (widget.post.poll != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: FlutterPolls(
                            loadingWidget: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: AppColors.theme['primaryColor'],
                                strokeWidth: 2,
                              ),
                            ),
                            leadingVotedProgessColor: AppColors.theme['secondaryBgColor'],
                            votedBackgroundColor: AppColors.theme['secondaryColor'],
                            votedProgressColor: AppColors.theme['secondaryBgColor'],
                            pollOptionsSplashColor: AppColors.theme['secondaryBgColor'],
                            createdBy: "CSI",
                            pollId: widget.post.poll?.pollId,
                            onVoted: (PollOption pollOption, int newTotalVotes) async {
                              await Future.delayed(const Duration(seconds: 2));
                              return true;
                            },
                            pollTitle: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.post.poll!.question ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
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
                            votedPercentageTextStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LikeButton(
                            isLiked: widget.post.like?[appUserProvider.user?.userID] ?? false,
                            likeCount: widget.post.like?.length ?? 0,
                            likeBuilder: (bool isLiked) {
                              return isLiked
                                  ? Icon(Icons.thumb_up, color: AppColors.theme["primaryColor"],)
                                  : Icon(Icons.thumb_up_alt_outlined, color: AppColors.theme["primaryColor"],);
                            },
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: AppColors.theme["primaryColor"],
                              dotSecondaryColor: AppColors.theme["secondaryBgColor"],
                            ),
                            circleColor: CircleColor(
                                start: AppColors.theme["primaryColor"], end:  AppColors.theme["secondaryBgColor"]
                            ),
                          ),
                        ),

                        //comment button

                        Padding(
                          padding: EdgeInsets.all(8),

                          child: InkWell(
                            onTap: (){
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

                                  SizedBox(width: 8,),

                                  Text("${widget.post.comment?.length ?? 0}",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),

                                ],
                              ),
                            ),
                          ),


                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      },

    );
  }
}
