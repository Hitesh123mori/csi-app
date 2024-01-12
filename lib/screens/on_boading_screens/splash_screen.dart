import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent));

      Navigator.pushReplacement(context, RightToLeft(DrawerScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
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
  }
}
