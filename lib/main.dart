import 'package:csi_app/screens/on_boading_screens/splash_screen.dart';
import 'package:flutter/material.dart' ;

late Size mq ;
bool isKeyboardOpen = false ;
void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen())
    ;
  }
}
