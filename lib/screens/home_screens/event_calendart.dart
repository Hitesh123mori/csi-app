import 'package:flutter/material.dart' ;

import '../../main.dart';

class EventCal extends StatefulWidget {
  const EventCal({super.key});

  @override
  State<EventCal> createState() => _EventCalState();
}

class _EventCalState extends State<EventCal> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.35),
      child: Text("Event Calendar",style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
