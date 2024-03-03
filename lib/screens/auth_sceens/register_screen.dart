import 'package:csi_app/apis/FireStoreAPIs/UserProfileAPI.dart';
import 'package:csi_app/apis/FirebaseAuth/FirebaseAuth.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:flutter/material.dart';
import 'package:csi_app/screens/auth_sceens/login_screen.dart';
import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/buttons/auth_button.dart';
import 'package:csi_app/utils/widgets/text_feilds/auth_text_feild.dart';

class RegisterScreen extends StatefulWidget {
  String email;
  String password;
  RegisterScreen({required this.email, required this.password, Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _codeforcesController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  String _selectedItem = "1";

  List<String> _items = ['1', '2', '3', '4'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateButtonState);
    _yearController.addListener(updateButtonState);
    _codeforcesController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _yearController.text.isNotEmpty &&
          _codeforcesController.text.isNotEmpty;

    });
  }

  @override
  void dispose() {
    _nameController.removeListener(updateButtonState);
    _yearController.removeListener(updateButtonState);
    _codeforcesController.removeListener(updateButtonState);
    super.dispose();
  }




  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your year';
    }
    return null;
  }

  String? _validateCodeforcesID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Codeforces ID';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['secondaryBgColor'],
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Image.asset("assets/images/auth_images/info.png"),
                          height: 250,
                          width: 250,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your information",
                              style: TextStyle(
                                color: AppColors.theme['primaryColor'],
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomAuthTextField(
                              hintText: 'Ex.Charles Babbage',
                              isNumber: false,
                              prefixicon: Icon(Icons.person),
                              controller: _nameController,
                              obsecuretext: false,
                              validator: _validateFullName,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Choose Year",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.theme['tertiaryColor']),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 60,
                              child: DropdownButtonFormField<String>(
                                hint: Text("Choose Year"),
                                decoration: InputDecoration(
                                  prefixIconColor: AppColors.theme['tertiaryColor'],
                                  prefixIcon: Icon(Icons.calendar_today_rounded),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.theme['primaryColor']!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.theme['primaryColor']!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.theme['primaryColor']!),
                                  ),
                                ),
                                dropdownColor: AppColors.theme['secondaryBgColor'], // Set dropdown menu background color
                                value: _yearController.text.isNotEmpty ? _yearController.text : null,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _yearController.text = newValue!;
                                  });
                                },
                                items: _items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value + " Year"),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Codeforces ID",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomAuthTextField(
                              hintText: 'Your Codeforces ID',
                              isNumber: false,
                              prefixicon: Icon(Icons.code),
                              controller: _codeforcesController,
                              obsecuretext: false,
                              validator: _validateCodeforcesID,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AuthButton(
                              onpressed: isButtonEnabled
                                  ? () async {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        // for signup
                                        final res = await FirebaseAuth.signUp(widget.email, widget.password);
                                        print("#res-signup: $res");

                                        // for database
                                        final res2 =  await UserProfile.signupUser(_nameController.text, _yearController.text, _codeforcesController.text);
                                        print("#res2-signup: $res2");

                                        if(res == 'Registered' && res2 == 'ok' && res2 !=null)
                                          Navigator.pushReplacement(context, LeftToRight(HomeScreen()));

                                      }
                                    }
                                  : () {
                                      FocusScope.of(context).unfocus();
                                    },
                              name: 'Sign Up',
                              bcolor: isButtonEnabled
                                  ? AppColors.theme['primaryColor']
                                  : AppColors.theme['disableButtonColor']
                                      .withOpacity(0.4),
                              tcolor: isButtonEnabled
                                  ? AppColors.theme['secondaryColor']
                                  : AppColors.theme['tertiaryColor']
                                      .withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
