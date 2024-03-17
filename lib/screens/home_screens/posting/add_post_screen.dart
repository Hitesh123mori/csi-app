import 'dart:developer';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/apis/googleAIPs/drive/DriveApi.dart';
import 'package:csi_app/models/post_model/image_model.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/screens/home_screens/posting/attach_pdf.dart';
import 'package:csi_app/screens/home_screens/posting/poll%20screen.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:csi_app/utils/widgets/posting/image_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../apis/StorageAPIs/StorageAPI.dart';
import '../../../main.dart';
import '../../../side_transition_effects/TopToBottom.dart';
import '../../../utils/shimmer_effects/post_screen_shimmer_effect.dart';
import '../../../utils/widgets/dialog_box.dart';
import 'add_image.dart';

class AddPostScreen extends StatefulWidget {

  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final CarouselController _controller = CarouselController();
  TextEditingController _descriptionController = TextEditingController();
  bool isFirst = true;
  bool isButtonEnabled = false;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(updateButtonState);
  }

  void updateButtonState() {
    if (!isFirst) {
      setState(() {
        isButtonEnabled = _descriptionController.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Consumer2<PostProvider, AppUserProvider>(
      builder: (context, postProvider, appUserProvider, child) {
        if (postProvider.post == null) {
          postProvider.post = Post();
        }
        if (postProvider.post != null && isFirst) {
          _descriptionController.text = postProvider.post?.description ?? "";
          isFirst = false;
        }
        return GestureDetector(
          child: Form(
            key: _formKey,
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.theme['primaryColor'],
                  selectionColor: AppColors.theme['primaryColor'].withOpacity(0.2),
                  selectionHandleColor: AppColors.theme['secondaryBgColor'].withOpacity(0.2),
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: AppColors.theme['backgroundColor'],
                appBar: _buildAppBar(context, postProvider, appUserProvider),
                floatingActionButton: _buildSpeedDial(postProvider),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        _buildDescriptionTextField(postProvider),
                        if ((postProvider.post?.images?.isNotEmpty ?? false) && !postProvider.forEdit) _buildImageCarousel(postProvider),
                        if ((postProvider.post?.isThereImage ?? false) && postProvider.forEdit) _buildImageCarouselFromNetwork(postProvider),
                        if (postProvider.post?.pdfLink?.isNotEmpty ?? false) _buildPdfViewer(postProvider),
                        if (postProvider.post?.poll != null) _buildPollContainer(postProvider),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, PostProvider postProvider, AppUserProvider appUserProvider) {
    return AppBar(
      surfaceTintColor: AppColors.theme['secondaryColor'],
      title: Text(
        postProvider.forEdit ? "Edit Post" : "Create Post",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.theme['secondaryColor'],
      leading: IconButton(
        onPressed: () {
          Navigator.push(context, TopToBottom(HomeScreen()));
        },
        icon: Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 32,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                postProvider.forEdit
                ? _editPost(context, postProvider, appUserProvider)
                : _uploadPost(context, postProvider, appUserProvider);

                postProvider.forEdit = false;
              }
            },
            child: Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                  postProvider.forEdit? "Update" : "Post",
                  style: TextStyle(
                    color: isButtonEnabled ? AppColors.theme['secondaryColor'] : AppColors.theme['tertiaryColor'].withOpacity(0.5),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: isButtonEnabled ? AppColors.theme['primaryColor'] : AppColors.theme['disableButtonColor'],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSpeedDial(PostProvider postProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: Icon(
            Icons.attach_file_outlined,
            color: AppColors.theme['secondaryColor'],
          ),
        ),
        backgroundColor: AppColors.theme['primaryColor'],
        children: [
          SpeedDialChild(
            backgroundColor: AppColors.theme['disableButtonColor'],
            child: Icon(Icons.image_outlined),
            label: "Image",
            onTap: () {
              _handleImageTap(postProvider);
            },
          ),
          SpeedDialChild(
            backgroundColor: AppColors.theme['disableButtonColor'],
            child: Icon(Icons.picture_as_pdf_outlined),
            label: "Pdf",
            onTap: () {
              _handlePdfTap(postProvider);
            },
          ),
          SpeedDialChild(
            backgroundColor: AppColors.theme['disableButtonColor'],
            child: Icon(Icons.poll_outlined),
            label: "Poll",
            onTap: () {
              _handlePollTap(postProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTextField(PostProvider postProvider) {
    return Container(
      child: TextFormField(
        onChanged: (_) {
          postProvider.post?.description = _descriptionController.text;
          postProvider.notify();
        },
        controller: _descriptionController,
        cursorColor: AppColors.theme['primaryColor'],
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Start writing your description here',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildImageCarousel(PostProvider postProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Attachment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.theme['tertiaryColor'],
              ),
            ),

            IconButton(
                onPressed: (){},
                icon: Icon(Icons.close, color: AppColors.theme["primaryColor"],)
            )
          ],
        ),
        SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 500.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: postProvider.post?.images!.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.theme['backgroundColor'],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            postProvider.post?.images?.remove(image);
                            HelperFunctions.showToast("Image Deleted!");
                            postProvider.notify();
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppColors.theme['secondaryColor'],
                            ),
                          ),
                        ),
                        StreamBuilder(
                          stream: image.readAsBytes().asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text("Error");
                            else if (snapshot.hasData) {
                              Uint8List bytes = Uint8List(0);
                              return Image.memory(
                                snapshot.data as Uint8List ?? bytes,
                                fit: BoxFit.cover,
                                height: 300,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.theme['primaryColor'],
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImageCarouselFromNetwork(PostProvider postProvider){
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      child: StreamBuilder(
        stream: StorageAPI.getImage(postProvider.post!.postId).asStream(),
        builder: (context, snap) {
          if (snap.hasData) {
            log("#hd: ${snap.data}");
            postProvider.post?.imageModelList = snap.data;
            if (postProvider.post?.imageModelList?.isEmpty ?? true) return PostShimmerEffect();
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: postProvider.post?.imageModelList?.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    log("#imgUrl-home-screen: ${postProvider.post?.imageModelList?[itemIndex]}");
                    return ImageFrame(imageModel: postProvider.post?.imageModelList?[itemIndex] ?? ImageModel(), provider: postProvider);
                  },
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: postProvider.post?.images?.length != 1,
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
                  children: postProvider.post!.imageModelList!.asMap().entries.map((entry) {
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
    );
  }

  Widget _buildPdfViewer(PostProvider postProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attachment",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.theme['tertiaryColor'],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 500,
          width: mq.width * 1,
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
              postProvider.post!.pdfLink!,
              key: _pdfViewerKey,
              scrollDirection: PdfScrollDirection.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPollContainer(PostProvider postProvider) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.theme["tertiaryColor"]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  postProvider.post?.poll = null;
                  setState(() {});
                },
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
              FlutterPolls(
                pollEnded: true,
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
                pollId: postProvider.post?.poll?.pollId,
                onVoted: (PollOption pollOption, int newTotalVotes) async {
                  await Future.delayed(const Duration(seconds: 2));
                  return true;
                },
                pollTitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    postProvider.post?.poll!.question ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                pollOptions: List<PollOption>.from(
                  postProvider.post!.poll!.options!.map(
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
            ],
          ),
        ),
      ),
    );
  }

  void _uploadPost(
    BuildContext context,
    PostProvider postProvider,
    AppUserProvider appUserProvider,
  ) async {
    postProvider.post?.isThereImage = postProvider.post?.images?.isNotEmpty ?? false;
    postProvider.post?.createBy = appUserProvider.user!.userID;
    postProvider.post?.createTime = DateTime.now().millisecondsSinceEpoch.toString();
    postProvider.post?.images?.forEach((element) async {
      await StorageAPI.uploadPostImg(postProvider.post!.postId, await element.readAsBytes());
    });
    PostAPI.postUpload(postProvider.post!);
    postProvider.post = null;
    Navigator.push(context, RightToLeft(HomeScreen()));
  }


  void _editPost(
    BuildContext context,
    PostProvider postProvider,
    AppUserProvider appUserProvider,
  ) async {

    log("#Updating...");

    postProvider.post?.isThereImage = (postProvider.post?.images?.isNotEmpty ?? false ) || (postProvider.post?.imageModelList?.isNotEmpty ?? false);
    postProvider.post?.createBy = appUserProvider.user!.userID;
    // postProvider.post?.createTime = DateTime.now().millisecondsSinceEpoch.toString();

    postProvider.post?.images?.forEach((element) async {
      await StorageAPI.uploadPostImg(postProvider.post!.postId, await element.readAsBytes());
    });
    final res = await PostAPI.postUpload(postProvider.post!);
    log("#res: $res");
    if(res == "Posted") {
      postProvider.post = null;
      Navigator.push(context, RightToLeft(HomeScreen()));

      HelperFunctions.showToast(res);
    }
    else {
      HelperFunctions.showToast("Error updating post.");
    }

  }

  void _handleImageTap(PostProvider postProvider) {
    final post = postProvider.post;
    final hasImage = post?.images?.isNotEmpty ?? false;
    final hasPdf = (post?.pdfLink ?? "") != "";

    if (!hasPdf) {
      post?.description = _descriptionController.text;
      postProvider.notify();
      Navigator.push(context, BottomToTop(AddImage()));
    } else if (!hasImage && hasPdf) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            actionButton1Name: "Delete pdf",
            actionButton2Name: "Cancel",
            title: 'Attachment Issue',
            description: 'You cannot attach both PDF and image to the same post.',
            icon: Icons.error_outline_outlined,
            onAction1Pressed: () {
              setState(() {
                DriveAPI.deleteFileFromDrive(postProvider.post?.pdfLink);
                postProvider.post?.pdfLink = "";
                Navigator.pop(context);
              });
            },
            onAction2Pressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  void _handlePdfTap(PostProvider postProvider) {
    final hasImages = (postProvider.post?.images?.isNotEmpty ?? false ) || (postProvider.post?.imageModelList?.isNotEmpty ?? false);
    if (hasImages) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            actionButton1Name: "Delete images",
            actionButton2Name: "Cancel",
            title: 'Attachment Issue',
            description: 'You cannot attach both PDF and image to the same post.',
            icon: Icons.error_outline_outlined,
            onAction1Pressed: () async {
              await StorageAPI.deletePostImg(postProvider.post?.imageModelList);
              setState(() {
                postProvider.post?.images?.clear();
                postProvider.post?.imageModelList?.clear();
                postProvider.post?.isThereImage = false;
                postProvider.notify();
                HelperFunctions.showToast("Images Deleted");
                Navigator.pop(context);
              });
            },
            onAction2Pressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    } else {
      postProvider.post?.description = _descriptionController.text;
      postProvider.notify();
      Navigator.push(context, BottomToTop(AttachPdf()));
    }
  }

  void _handlePollTap(PostProvider postProvider) {
    postProvider.post?.description = _descriptionController.text;
    postProvider.notify();
    Navigator.push(context, BottomToTop(PollScreen()));
  }
}
