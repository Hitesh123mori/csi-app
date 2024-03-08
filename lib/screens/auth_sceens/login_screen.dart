import 'package:csi_app/apis/FirebaseAuth/FirebaseAuth.dart';
import 'package:csi_app/screens/auth_sceens/otp_screen.dart';
import 'package:csi_app/screens/auth_sceens/register_screen.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/buttons/auth_button.dart';
import '../../utils/widgets/text_feilds/auth_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // textfields controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _isPasswordHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateButtonState);
    _passController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          _emailController.text.isNotEmpty && _passController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(updateButtonState);
    _passController.removeListener(updateButtonState);
    super.dispose();
  }

  // validation of email
  // validation of email
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else {
      value = value.trim();
      if (!value.endsWith('@nirmauni.ac.in')) {
        return 'Invalid email domain';
      }
    }
    return null;
  }

  // validation of password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!value.contains(new RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    } else if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.theme['primaryColor'],
              selectionColor: AppColors.theme['primaryColor'].withOpacity(0.2),
              selectionHandleColor: AppColors.theme['secondaryBgColor'].withOpacity(0.2),
            )
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['secondaryBgColor'],
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Image.asset("assets/images/auth_images/login.png"),
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
                              "Log in to your account",
                              style: TextStyle(
                                color: AppColors.theme['primaryColor'],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Welcome back! Please enter your details.",
                              style: TextStyle(
                                color: AppColors.theme['tertiaryColor'],
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomAuthTextField(
                              hintText: 'Example@nirmauni.ac.in',
                              isNumber: false,
                              prefixicon: Icon(Icons.email),
                              controller: _emailController,
                              obsecuretext: false,
                              validator: _validateEmail,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.theme['tertiaryColor']),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomAuthTextField(
                              hintText: 'Enter your password',
                              isNumber: false,
                              prefixicon: Icon(Icons.lock),
                              controller: _passController,
                              obsecuretext: _isPasswordHidden,
                              suffix: IconButton(
                                icon: Icon(
                                  _isPasswordHidden
                                      ? (Icons.visibility_off)
                                      : (Icons.visibility),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                              ),
                              validator: _validatePassword,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AuthButton(
                              onpressed: isButtonEnabled
                                  ? () async {
                                       FocusScope.of(context).unfocus();
                                       if(_formKey.currentState!.validate()) {
                                         String res = await FirebaseAuth.signIn(_emailController.text, _passController.text);
                                         print("res-logIN: $res");
                                         if(res == 'Logged In')
                                            Navigator.pushReplacement(context, LeftToRight(HomeScreen()));
                                       }
                                    }
                                  : () {
                                     FocusScope.of(context).unfocus();
                                    },
                              name: 'Log In',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  color: AppColors.theme['tertiaryColor'],fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, LeftToRight(OtpScreen()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: AppColors.theme['primaryColor'],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ))
                          ],
                        ),
                      )
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
