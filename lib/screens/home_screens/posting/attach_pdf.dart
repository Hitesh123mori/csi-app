import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart' ;

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

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //for pdf name
  TextEditingController _pdfnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // for pdf name
    _pdfnameController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isAttachpdfButtonEnabled = _pdfnameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _pdfnameController.removeListener(updateButtonState);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                  onTap: isAttachpdfButtonEnabled ? () {
                    if(_formKey.currentState!.validate()){

                      //todo : here slogic

                    }
                  } : (){},
                  child:Container(
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
                        )),
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
          body:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Text(
                  "Please select a PDF from your device and provide a title. This will help your document be discovered more easily.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.theme['tertiaryColor']),
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
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {


                    //todo : add upload/choose pdf logic here




                  },
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
                    'Choose Pdf',
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
  }
}
