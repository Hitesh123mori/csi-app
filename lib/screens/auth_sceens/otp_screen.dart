import 'package:csi_app/screens/auth_sceens/set_password.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../side_transition_effects/left_right.dart';
import '../../side_transition_effects/right_left.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/buttons/auth_button.dart';
import '../../utils/widgets/text_feilds/auth_text_feild.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;
  bool enablePinput = false;
  bool isButtonClicked = false;
  bool isPinFilled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateButtonState);

    defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.theme['disableButtonColor']!),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.theme['primaryColor']),
      borderRadius: BorderRadius.circular(10),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration:
          defaultPinTheme.decoration?.copyWith(color: Colors.transparent),
    );
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(updateButtonState);
    super.dispose();
  }

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

  late final PinTheme defaultPinTheme;
  late final PinTheme focusedPinTheme;
  late final PinTheme submittedPinTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['secondaryBgColor']!,
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
                          child: Image.asset(
                              "assets/images/auth_images/verifyemail.png"),
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
                              "Verify your email",
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
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
                              onChange: (_) {
                                setState(() {
                                  enablePinput = false;
                                  isButtonClicked = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (isButtonClicked &&
                                isButtonEnabled &&
                                enablePinput)
                              Text(
                                  "Please check your email. We have sent you an OTP to ${_emailController.text}.",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            if (isButtonClicked &&
                                isButtonEnabled &&
                                enablePinput)
                              Pinput(
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                showCursor: false,
                                onChanged: (_) {
                                  setState(() {
                                    isPinFilled = false;
                                    updateButtonState();
                                  });
                                },
                                onCompleted: (pin) {
                                  setState(() {
                                    isPinFilled = true;
                                    updateButtonState();
                                  });
                                  print(pin);
                                },
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            (isButtonClicked && isButtonEnabled && enablePinput)
                                ? AuthButton(
                                    onpressed: () {
                                      if (isPinFilled) {
                                        Navigator.pushReplacement(context,
                                            LeftToRight(SetPassword()));
                                      }
                                    },
                                    name: 'Verify',
                                    bcolor: isPinFilled
                                        ? AppColors.theme['primaryColor']!
                                        : AppColors.theme['disableButtonColor']!
                                            .withOpacity(0.4),
                                    tcolor: isPinFilled
                                        ? AppColors.theme['secondaryColor']!
                                        : AppColors.theme['tertiaryColor']!
                                            .withOpacity(0.5),
                                  )
                                : AuthButton(
                                    onpressed: () {
                                      if (isButtonEnabled) {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isButtonClicked = true;
                                            enablePinput = true;
                                          });
                                        }
                                      }
                                    },
                                    name: 'Get OTP',
                                    bcolor: isButtonEnabled
                                        ? AppColors.theme['primaryColor']!
                                        : AppColors.theme['disableButtonColor']!
                                            .withOpacity(0.4),
                                    tcolor: isButtonEnabled
                                        ? AppColors.theme['secondaryColor']!
                                        : AppColors.theme['tertiaryColor']!
                                            .withOpacity(0.5),
                                  ),
                          ],
                        ),
                      ),
                      if (isButtonClicked && isButtonEnabled && enablePinput)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: AppColors.theme['primaryColor']!,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                color: AppColors.theme['tertiaryColor']!,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  RightToLeft(LoginScreen()),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: AppColors.theme['primaryColor']!,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
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
