import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/utils/Reaction_button.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../helper_functions/function.dart';
import '../../../main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showMore = false;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  var parser = EmojiParser();
  var coffee = Emoji('coffee', '☕');
  var heart = Emoji('heart', '❤');
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    String description = widget.post.description ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Material(
        elevation: 0.2,
        child: Container(
          width: mq.width,
          color: AppColors.theme['secondaryColor'],
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 0,
                    surfaceTintColor: AppColors.theme['secondaryColor'],
                    color: AppColors.theme['secondaryColor'],
                    child: ListTile(
                      title: Text(
                        "Computer Society of India",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Nirma University Club",
                        style:
                        TextStyle(color: AppColors.theme['tertiaryColor']),
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/images/csi_logo.png"),
                        radius: 25,
                      ),
                      contentPadding: EdgeInsets.only(left: 1),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert_outlined),
                      ),
                    ),
                  ),
                  if (widget.post.isDescription)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showMore
                            ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: buildContent(description),
                        )
                            : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: buildContent(_truncateDescription(description)),
                        ),
                        if (description.length > 100)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showMore = !showMore;
                              });
                            },
                            child: Text(
                              showMore ? 'Show Less' : 'Show More',
                              style: TextStyle(
                                  color: AppColors.theme['tertiaryColor']),
                            ),
                          ),

                      ],
                    ),
                  if (widget.post.isAnyAttachment &&
                      widget.post.images != null)
                    Container(
                      color: AppColors.theme['backgroundColor'],
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13.0),
                                  child: Text(
                                      widget.post.attachmentname!,
                                      style: TextStyle(
                                          color: AppColors
                                              .theme['tertiaryColor'],
                                          fontWeight:
                                          FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13.0),
                                  child: Text(
                                    widget.post.images!.length.toString() + " Images",
                                    style: TextStyle(
                                        color: AppColors.theme['tertiaryColor'],
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: widget.post.images!.length,
                                carouselController: _controller,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) =>
                                    Image.asset(
                                        widget.post.images![itemIndex]),
                                options: CarouselOptions(
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: widget.post.images!.length != 1,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                  aspectRatio: 1.0,
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
                                children: widget.post.images!.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context).brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (widget.post.isAnyAttachment && widget.post.isPdfPost)
                    Container(
                      height: 40,
                      color: AppColors.theme['backgroundColor'],
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0),
                              child: Text(widget.post.attachmentname!,
                                  style: TextStyle(
                                      color: AppColors
                                          .theme['tertiaryColor'],
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0),
                              child: InkWell(
                                onTap: () async {
                                  print("#download");
                                  await http.get(Uri.parse(widget.post.pdflink!));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Download",
                                        style: TextStyle(
                                            color: AppColors
                                                .theme['tertiaryColor'],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 3,),
                                    Icon(
                                      Icons.download_rounded,
                                      size: 20,
                                      color: AppColors.theme['tertiaryColor'],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  if (widget.post.isAnyAttachment && widget.post.isPdfPost)
                    Container(
                      color: AppColors.theme['backgroundColor'],
                      height: 400,
                      //todo: can't view on app release
                      child: SfPdfViewer.network(
                        canShowScrollHead:false,
                        pageSpacing: 2,
                        canShowPageLoadingIndicator:false,
                        widget.post.pdflink!,
                        key: _pdfViewerKey,
                        scrollDirection: PdfScrollDirection.horizontal,
                      ),
                    ),
                  if (widget.post.isPoll)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: FlutterPolls(
                          loadingWidget: SizedBox(width: 15, height:15, child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2,)),
                          leadingVotedProgessColor: Colors.grey,
                          votedBackgroundColor: Colors.black12,
                          votedProgressColor: Colors.grey,
                          createdBy: "CSI",
                          pollId: widget.post.poll?.id,
                          onVoted:
                              (PollOption pollOption, int newTotalVotes) async {
                            await Future.delayed(const Duration(seconds: 2));
                            return true;
                          },
                          pollTitle: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.post.poll!.question,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          pollOptions: List<PollOption>.from(
                            widget.post.poll!.options.map(
                                  (option) {
                                var a = PollOption(
                                  id: option.id,
                                  title: Text(
                                    option.title,
                                    style: TextStyle(
                                        color: AppColors.theme['tertiaryColor']),
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
                  SizedBox(
                    height: 58,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ReactionBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateDescription(String content) {
    return content.length > 100 ? content.substring(0, 100) + '... ' : content;
  }

  Widget buildContent(String content) {
    List<InlineSpan> children = [];

    RegExp regex = RegExp(r'https?://\S+');
    Iterable<RegExpMatch> matches = regex.allMatches(content);

    int currentIndex = 0;

    for (RegExpMatch match in matches) {
      String url = match.group(0)!;
      int start = match.start;
      int end = match.end;

      children.add(TextSpan(text: content.substring(currentIndex, start)));

      children.add(
        TextSpan(
          text: url,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Functions.launchURL(url);
            },
        ),
      );

      currentIndex = end;
    }

    children.add(TextSpan(text: content.substring(currentIndex)));

    return RichText(
        text: TextSpan(
          children: children,
          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontSize: 15),
        ));
  }
}