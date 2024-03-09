import 'package:carousel_slider/carousel_slider.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/screens/home_screens/posting/attach_pdf.dart';
import 'package:csi_app/screens/home_screens/posting/poll%20screen.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import '../../../main.dart';
import '../../../side_transition_effects/TopToBottom.dart';
import '../../../utils/widgets/dialog_box.dart';
import '../../../utils/widgets/posting/poll_text_field.dart';
import '../../../utils/widgets/text_feilds/auth_text_feild.dart';
import 'add_image.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //for post description
  TextEditingController _descriptionController = TextEditingController();

  bool isFirst = true;

  int _current = 0;
  bool isButtonEnabled = false;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(updateButtonState);
  }

  void updateButtonState() {
    if (!isFirst)
      setState(() {
        isButtonEnabled = _descriptionController.text.isNotEmpty;
      });
  }

  @override
  void dispose() {
    _descriptionController.removeListener(updateButtonState);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<PostProvider>(builder: (context, value, child) {
      if (value.post != null && isFirst) {
        _descriptionController.text = value.post?.description ?? "";
        isFirst = false;
      }
      return GestureDetector(
        // onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.theme['primaryColor'],
                  selectionColor:
                      AppColors.theme['primaryColor'].withOpacity(0.2),
                  selectionHandleColor:
                      AppColors.theme['secondaryBgColor'].withOpacity(0.2),
                )),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.theme['backgroundColor'],
              appBar: AppBar(
                surfaceTintColor: AppColors.theme['secondaryColor'],
                title: Text(
                  "Create Post",
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          //todo : add post logic here
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        child: Center(
                            child: Text(
                          "Post",
                          style: TextStyle(
                            color: isButtonEnabled
                                ? AppColors.theme['secondaryColor']
                                : AppColors.theme['tertiaryColor']
                                    .withOpacity(0.5),
                          ),
                        )),
                        decoration: BoxDecoration(
                          color: isButtonEnabled
                              ? AppColors.theme['primaryColor']
                              : AppColors.theme['disableButtonColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: Padding(
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
                        final post = value.post;
                        final hasImage = post?.isThereImage ?? false;
                        final hasPdf = (post?.pdfLink ?? "") != "";

                        if (!hasImage && !hasPdf) {
                          post?.description = _descriptionController.text;
                          value.notify();
                          Navigator.push(context, BottomToTop(AddImage()));
                        }
                        else if (!hasImage && hasPdf) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                actionButton1Name: "Delete pdf",
                                actionButton2Name: "Cancel",
                                title: 'Attachment Issue',
                                description:
                                    'You cannot attach both PDF and image to the same post.',
                                icon: Icons.error_outline_outlined,
                                onAction1Pressed: () {
                                  setState(() {
                                    value.post?.pdfLink = "";
                                    Navigator.pop(context) ;
                                  });
                                },
                                onAction2Pressed: () {
                                  Navigator.pop(context) ;
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                SpeedDialChild(
                  backgroundColor: AppColors.theme['disableButtonColor'],
                  child: Icon(Icons.picture_as_pdf_outlined),
                  label: "Pdf",
                  onTap: () {
                    final post = value.post;
                    final hasImages = (post?.images?.isNotEmpty ?? false);
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
                            onAction1Pressed: () {
                              setState(() {
                                value.post?.images?.clear();
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
                      value.post?.description = _descriptionController.text;
                      value.notify();
                      Navigator.push(context, BottomToTop(AttachPdf()));
                    }
                  },
                ),
                SpeedDialChild(
                      backgroundColor: AppColors.theme['disableButtonColor'],
                      child: Icon(Icons.poll_outlined),
                      label: "Poll",
                      onTap: () {
                        value.post?.description = _descriptionController.text;
                        value.notify();
                        Navigator.push(context, BottomToTop(PollScreen()));
                      },
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          onChanged: (_) {
                            value.post?.description =
                                _descriptionController.text;
                            value.notify();
                          },
                          controller: _descriptionController,
                          cursorColor: AppColors.theme['primaryColor'],
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: 'Start writing your description here',
                              border: InputBorder.none),
                        ),
                      ),
                      if (value.post?.images?.isNotEmpty ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attachement",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.theme['tertiaryColor']),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 400.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                              items: value.post?.images!.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.theme['backgroundColor'],
                                      ),
                                      child: Image.file(
                                        File(image),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      if (value.post?.pdfLink?.isNotEmpty ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attachement",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.theme['tertiaryColor']),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                  value.post!.pdfLink!,
                                  key: _pdfViewerKey,
                                  scrollDirection:
                                      PdfScrollDirection.horizontal,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
