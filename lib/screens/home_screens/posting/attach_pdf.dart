import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../apis/googleAIPs/drive/DriveApi.dart';
import '../../../main.dart';
import '../../../side_transition_effects/TopToBottom.dart';
import '../../../utils/widgets/text_feilds/auth_text_feild.dart';
import 'add_post_screen.dart';

class AttachPdf extends StatefulWidget {
  const AttachPdf({super.key});

  @override
  State<AttachPdf> createState() => _AttachPdfState();
}

class _AttachPdfState extends State<AttachPdf> {
  bool isAttachpdfButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  TextEditingController _pdfnameController = TextEditingController();
  String downloadUrl = "";
  late FocusNode _textFieldFocusNode;
  bool isPdfAttached  = false ;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pdfnameController.addListener(updateButtonState);
    _textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pdfnameController.removeListener(updateButtonState);
    _textFieldFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isAttachpdfButtonEnabled =
          _pdfnameController.text.isNotEmpty && downloadUrl.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    mq   = MediaQuery.of(context).size ;
    return Consumer<PostProvider>(builder: (context, value, child) {
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
                "Attach Pdf",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColors.theme['secondaryColor'],
              surfaceTintColor: AppColors.theme['secondaryColor'],
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: isAttachpdfButtonEnabled
                        ? () {
                      if (_formKey.currentState!.validate()) {
                        print("#urlPdf : ${value.post?.pdfLink}");
                        value.post?.pdfLink = downloadUrl;
                        value.post?.isThereImage = false;
                        value.post?.attachmentName  = _pdfnameController.text ;
                        downloadUrl = "";
                        Navigator.push(context, TopToBottom(AddPostScreen()));

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
                            color: isAttachpdfButtonEnabled
                                ? AppColors.theme['secondaryColor']
                                : AppColors.theme['tertiaryColor']
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: isAttachpdfButtonEnabled
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
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    "Please select a PDF from your device and provide a title. This will help your document be discovered more easily.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.theme['tertiaryColor']
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomAuthTextField(
                    controller: _pdfnameController,
                    hintText: 'Enter title of attachment',
                    isNumber: false,
                    prefixicon: Icon(Icons.drive_file_rename_outline),
                    obsecuretext: false,
                    focusNode: _textFieldFocusNode, // Assign FocusNode
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  if (downloadUrl != "")
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        top: 0,
                      ),
                      child: Container(
                        height: 500,
                        width: mq.width*1,
                        decoration: BoxDecoration(
                          color: AppColors.theme['backgroundColor'],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfPdfViewer.network(
                            downloadUrl,
                            pageLayoutMode: PdfPageLayoutMode.continuous,
                            canShowScrollHead: false,
                            pageSpacing: 2,
                            canShowPageLoadingIndicator: false,
                            key: _pdfViewerKey,
                            scrollDirection: PdfScrollDirection.horizontal,
                          ),
                        ),
                      ),
                    ),

                  OutlinedButton(
                    onPressed: () async {
                      _textFieldFocusNode.requestFocus();
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(Duration(seconds: 5));
                      Map<String, String>? uploadResult =
                      await DriveAPI.uploadFile();

                      setState(() {
                        _isLoading = false ;
                      });

                      if (uploadResult != null &&
                          uploadResult.containsKey("File uploaded")) {
                        downloadUrl = uploadResult["File uploaded"]!;
                        isPdfAttached = true ;
                        // value.notify();
                        setState(() {});
                      } else if (uploadResult != null &&
                          uploadResult.containsKey("Error")) {
                        String errorMessage = uploadResult["Error"]!;
                        print(
                          'Error occurred during file upload: $errorMessage',
                        );
                      } else {
                        print(
                          'Error: File upload failed or user canceled the file picking',
                        );
                      }
                      updateButtonState(); // Update button state after choosing PDF
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: AppColors.theme['primaryColor'],
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      surfaceTintColor: MaterialStateProperty.all<Color>(
                        AppColors.theme['primaryColor'],
                      ),
                    ),
                    child: _isLoading ?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Container(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.theme['tertiaryColor'],
                              ),
                            ),
                          ),
                        SizedBox(width:  10),
                        Center(
                          child: Text(
                            "Uploading...",
                            style: TextStyle(
                              color: AppColors.theme['tertiaryColor'],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ): Text(
                      isPdfAttached ?  "Uploaded" : 'Choose Pdf',
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
    });
  }
}

