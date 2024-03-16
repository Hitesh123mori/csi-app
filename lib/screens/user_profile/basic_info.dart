import 'dart:typed_data';
import 'package:csi_app/apis/FireStoreAPIs/UserProfileAPI.dart';
import 'package:csi_app/apis/googleAIPs/drive/DriveApi.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:csi_app/utils/widgets/ProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/colors.dart';

import '../../utils/widgets/buttons/auth_button.dart';
import '../../utils/widgets/text_feilds/auth_text_feild.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _items = ['1', '2', '3', '4'];
  TextEditingController _yearController = TextEditingController();
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();
    _yearController.text = Provider.of<AppUserProvider>(context, listen: false).user?.year ?? '';
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
      builder: (context, appUserProvider, child) {
        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: AppColors.theme['backgroundColor'],
            appBar: AppBar(
              surfaceTintColor: AppColors.theme['secondaryColor'],
              title: Text(
                "Edit Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.theme['tertiaryColor'],
                ),
              ),
              backgroundColor: AppColors.theme['secondaryColor'],
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 32,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mq.height * .05),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          ProfilePhoto(url: appUserProvider.user?.profilePhotoUrl, name: appUserProvider.user?.name, radius: 70,),
                          InkWell(
                            radius: 10,
                            onTap: () async {
                              if ((appUserProvider.user?.profilePhotoUrl != "") ^ (appUserProvider.user?.profilePhotoUrl != null)) {
                                print("#old-dp-url: ${appUserProvider.user?.profilePhotoUrl}");
                                bool res = await DriveAPI.deleteFileFromDrive(appUserProvider.user?.profilePhotoUrl);
                                if (!res) {
                                  HelperFunctions.showToast("Unable to change profile photo at the moment");
                                  return;
                                }
                              }
                              Map<String, String> res = await DriveAPI.uploadImage();

                              if (res.containsKey("Image uploaded")) {
                                bool res2 =
                                    await UserProfile.updateUserProfile(appUserProvider.user?.userID, {"profile_photo_url": res["Image uploaded"]});
                                if (res2) {
                                  HelperFunctions.showToast("Profile photo updated");
                                  appUserProvider.user?.profilePhotoUrl = res["Image uploaded"];
                                  appUserProvider.notify();
                                } else {
                                  HelperFunctions.showToast("Error updating profile photo");
                                }
                              } else {
                                HelperFunctions.showToast(res["Error"] ?? "Something went wrong");
                              }
                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.edit,
                                color: AppColors.theme['secondaryColor'],
                              ),
                              backgroundColor: AppColors.theme['primaryColor'],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: mq.height * .05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          CustomAuthTextField(
                            hintText: "Update name",
                            isNumber: false,
                            prefixicon: Icon(Icons.drive_file_rename_outline),
                            obsecuretext: false,
                            initialText: appUserProvider.user?.name ?? "",
                            onChange: (value) {
                              // Update name
                              appUserProvider.user?.name = value;
                            },
                            onSaved: (value) {
                              // Save name
                              appUserProvider.user?.name = value;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomAuthTextField(
                            hintText: "Update about",
                            isNumber: false,
                            prefixicon: Icon(Icons.info_outline_rounded),
                            obsecuretext: false,
                            initialText: appUserProvider.user?.about ?? "",
                            onChange: (value) {
                              // Update about
                              appUserProvider.user?.about = value;
                            },
                            onSaved: (value) {
                              // Save about
                              appUserProvider.user?.about = value;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomAuthTextField(
                            hintText: "Update Codeforces id",
                            isNumber: false,
                            prefixicon: Icon(Icons.code),
                            obsecuretext: false,
                            initialText: appUserProvider.user?.cfId ?? "",
                            onChange: (value) {
                              // Update Codeforces id
                              appUserProvider.user?.cfId = value;
                            },
                            onSaved: (value) {
                              // Save Codeforces id
                              appUserProvider.user?.cfId = value;
                            },
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              hint: Text("Choose Year"),
                              decoration: InputDecoration(
                                prefixIconColor: AppColors.theme['tertiaryColor'],
                                prefixIcon: Icon(Icons.calendar_today_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.theme['primaryColor']!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.theme['primaryColor']!,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.theme['primaryColor']!,
                                  ),
                                ),
                              ),
                              dropdownColor: AppColors.theme['secondaryBgColor'],
                              value: _yearController.text.isNotEmpty ? _yearController.text : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _yearController.text = newValue!;
                                });
                                // Update Year
                                appUserProvider.user?.year = newValue;
                              },
                              onSaved: (String? newValue) {
                                // Save Year
                                appUserProvider.user?.year = newValue;
                              },
                              items: _items
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value + " Year"),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 20),
                          AuthButton(
                            onpressed: () async {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                // todo : save below data
                                print("Updated data:");
                                print("Name: ${appUserProvider.user?.name}");
                                print("About: ${appUserProvider.user?.about}");
                                print("Codeforces id: ${appUserProvider.user?.cfId}");
                                print("Year: ${appUserProvider.user?.year}");

                                Map<String, dynamic> fields = {
                                  "name": appUserProvider.user?.name,
                                  "about": appUserProvider.user?.about,
                                  "cf_id": appUserProvider.user?.cfId,
                                  "year": appUserProvider.user?.year,
                                };

                                bool succ = await UserProfile.updateUserProfile(appUserProvider.user?.userID, fields);

                                if (succ) {
                                  HelperFunctions.showToast("Profile Updated");
                                  appUserProvider.notify();
                                  Navigator.pop(context);
                                } else {
                                  HelperFunctions.showToast("Something went wrong please try again later");
                                }
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            name: _isLoading ? 'Updating...' : 'Update',
                            bcolor: AppColors.theme['primaryColor'],
                            tcolor: AppColors.theme['secondaryColor'],
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    )
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
