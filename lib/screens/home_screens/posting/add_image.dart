import 'package:flutter/material.dart';

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

  TextEditingController _imageNameController = TextEditingController();

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // for pdf name
    _imageNameController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isImageButtonEnabled = _imageNameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _imageNameController.removeListener(updateButtonState);

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
                            //todo : here slogic
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
                            : AppColors.theme['tertiaryColor'].withOpacity(0.5),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
