import 'package:carousel_slider/carousel_slider.dart';
import 'package:csi_app/apis/StorageAPIs/StorageAPI.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/post_provider.dart';
import '../../../side_transition_effects/TopToBottom.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/text_feilds/auth_text_feild.dart';
import 'add_post_screen.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool isImageButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _imageNameController = TextEditingController();
  List<XFile>? _imageList = [];
  // List<String> imagePaths = [];
  late FocusNode _textFieldFocusNode;

  Future<void> _pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null) {
      setState(() {
        _imageList = images;
        // imagePaths = _imageList!.map((XFile file) => file.path).toList();
      });
    }
    print("#images uploaded ${_imageList!.length} images");
  }

  @override
  void initState() {
    super.initState();
    _imageNameController.addListener(updateButtonState);
    _textFieldFocusNode = FocusNode(); // Initialize FocusNode
  }

  @override
  void dispose() {
    _imageNameController.removeListener(updateButtonState);
    _textFieldFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isImageButtonEnabled = _imageNameController.text.isNotEmpty &&
          (_imageList?.isNotEmpty ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, value, child) {
        return Form(
          key: _formKey,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.theme['backgroundColor'],
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(context, TopToBottom(AddPostScreen()));
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    size: 32,
                  ),
                ),
                title: Text(
                  "Attach Images",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.theme['secondaryColor'],
                surfaceTintColor: AppColors.theme['secondaryColor'],
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InkWell(
                      onTap: isImageButtonEnabled
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                if (value.post?.images == null)
                                  value.post?.images = [];

                                value.post?.images?.addAll(_imageList ?? []);
                                value.post?.attachmentName =
                                    _imageNameController.text;
                                value.notify();
                                Navigator.push(
                                    context, TopToBottom(AddPostScreen()));
                              }
                            }
                          : () {},
                      child: Container(
                        height: 40,
                        width: 100,
                        child: Center(
                            child: Text(
                          "Attach",
                          style: TextStyle(
                            color: isImageButtonEnabled
                                ? AppColors.theme['secondaryColor']
                                : AppColors.theme['tertiaryColor']
                                    .withOpacity(0.5),
                          ),
                        )),
                        decoration: BoxDecoration(
                          color: isImageButtonEnabled
                              ? AppColors.theme['primaryColor']
                              : AppColors.theme['disableButtonColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    Text(
                      "Please select a Images from your device and provide a title. This will help your document be discovered more easily.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['tertiaryColor']),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomAuthTextField(
                      controller: _imageNameController,
                      hintText: 'Enter title of attachment',
                      isNumber: false,
                      prefixicon: Icon(Icons.drive_file_rename_outline),
                      obsecuretext: false,
                      focusNode: _textFieldFocusNode, // Assign FocusNode
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_imageList?.isNotEmpty ?? false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Preview",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.theme['tertiaryColor']),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 500,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                            items: _imageList!.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.theme['backgroundColor'],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                _imageList?.remove(image);
                                                HelperFunctions.showToast("Image Deleted!");
                                                setState(() {});
                                              },
                                              icon: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Icon(Icons.close,color: AppColors.theme['secondaryColor'],))),
                                          Image.file(
                                            height: 400,
                                            File(image.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    OutlinedButton(
                      onPressed: _pickImages,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: AppColors.theme['primaryColor']),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        surfaceTintColor: MaterialStateProperty.all<Color>(
                            AppColors.theme['primaryColor']),
                      ),
                      child: Text(
                        !_imageList!.isNotEmpty
                            ? 'Select Images'
                            : "Reupload Images",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['tertiaryColor'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
