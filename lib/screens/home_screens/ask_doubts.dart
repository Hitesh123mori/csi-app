import 'package:flutter/material.dart' ;

import '../../main.dart';

class DoubtSection extends StatefulWidget {
  const DoubtSection({super.key});

  @override
  State<DoubtSection> createState() => _DoubtSectionState();
}

class _DoubtSectionState extends State<DoubtSection> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.35),
      child: Text("Drop your doubt here",style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
