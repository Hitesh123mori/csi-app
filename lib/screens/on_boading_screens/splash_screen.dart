import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../side_transition_effects/left_right.dart';
import '../../utils/colors.dart';
import '../home_screens/home_screen.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final AppUserProvider appUser;
  const SplashScreen({super.key, required this.appUser});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Future initUser() async {
  //   String? uid = FirebaseAPIs.auth.currentUser?.uid;
  //   print("#authId: $uid");
  //   if (uid != null) {
  //     Navigator.pushReplacement(context, LeftToRight(HomeScreen()));
  //   }
  //   print("#initUser complete");
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () async {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
      if (FirebaseAPIs.auth.currentUser != null) {
        try {
          await widget.appUser.initUser();
          Navigator.pushReplacement(context, LeftToRight(HomeScreen()));
        }
        catch (e){
          print("#Error: $e");
          widget.appUser.logOut();
          Navigator.pushReplacement(context, RightToLeft(OnboardingScreen()));

        }
      } else
        Navigator.pushReplacement(context, RightToLeft(OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
        builder: (context, appUserProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: AppColors.theme['primaryColor'],
            body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/csi_logo.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                      child: Text(
                        "Nirma University",
                        style: TextStyle(
                            color: AppColors.theme['secondaryColor'],
                            fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                      child: Text(
                        "Student Chapter",
                        style: TextStyle(
                            color: AppColors.theme['secondaryColor'],
                            fontSize: 25),
                      ),
                    )
                  ]),
            )),
      );
    });
  }
}
