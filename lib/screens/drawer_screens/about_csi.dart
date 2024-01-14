import 'package:flutter/material.dart' ;

import '../drawer.dart';


class AboutCSI extends StatefulWidget {
  const AboutCSI({super.key});

  @override
  State<AboutCSI> createState() => _AboutCSIState();
}

class _AboutCSIState extends State<AboutCSI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
           child: Text("ABOUT CSI"),
        ),
      ),
    );
  }
}
