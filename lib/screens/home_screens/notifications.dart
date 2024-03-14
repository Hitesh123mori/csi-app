import 'package:flutter/material.dart' ;
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/shimmer_effects/notification_card_shimmer_effect.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Scaffold(
      appBar : AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0.3,
        shadowColor: AppColors.theme['primaryColor'],
        backgroundColor: AppColors.theme['secondaryColor'],
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon : Icon(Icons.keyboard_arrow_left_sharp,size: 32,),

        ),
        title: Text(
          "Notifications",
          style: TextStyle(
              color: AppColors.theme['tertiaryColor'],
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.35),
        child: Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );

  }
}
