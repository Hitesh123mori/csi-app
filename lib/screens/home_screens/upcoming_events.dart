import 'package:flutter/material.dart' ;

import '../../main.dart';
import '../../utils/colors.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.35),
        child: Text("Upcoming Events",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
