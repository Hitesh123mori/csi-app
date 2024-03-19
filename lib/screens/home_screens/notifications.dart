import 'dart:developer';

import 'package:csi_app/apis/notification_apis/notifications_api.dart';
import 'package:csi_app/models/notification_model/Announcement.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
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
    return Consumer<AppUserProvider>(builder: (context, appUserProvider, child){
      return Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        appBar : AppBar(
          surfaceTintColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          child: StreamBuilder<List<Announcement>>(
            stream: NotificationApi.getNotification(appUserProvider.user?.userID ?? "").asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Announcement>? announcements = snapshot.data;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: announcements?.map((e) => NotificationCard(announcement: e,)).toList() ?? [Text("No Notification")],
                  ),
                );
              } else if (snapshot.hasError) {
                log("#error: ${snapshot.error}");
                return Text("Error occurred while getting notification");
              }
              return NotificationCardShimmerEffect();
            },
          ),
        ),
      );
    });
  }

}
