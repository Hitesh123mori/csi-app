import 'package:flutter/material.dart' ;
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/shimmer_effects/notification_card_shimmer_effect.dart';
import '../../utils/widgets/notificationns/notification_card.dart';

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
      backgroundColor: AppColors.theme['backgroundColor'],
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
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
          child: Column(
            children: [

              // todo: take this card , already created shimmer effect just use it
              NotificationCard(),


            ],
          ),
        ),
      )
    );

  }
}
