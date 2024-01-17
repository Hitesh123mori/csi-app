import 'package:flutter/material.dart' ;
import '../../main.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.35),
      child: Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
