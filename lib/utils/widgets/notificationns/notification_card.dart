import 'package:csi_app/models/notification_model/Announcement.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:flutter/material.dart';

import '../../helper_functions/function.dart';


class NotificationCard extends StatelessWidget {
  Announcement announcement;
  NotificationCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.theme['secondaryColor'],
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 1),
        title: Text("${announcement.fromUserName}",style: TextStyle(color: AppColors.theme['tertiaryColor'],fontWeight: FontWeight.bold),),
        subtitle: Text(truncateDescription("${announcement.message}")),
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.theme['secondaryBgColor'],
          child: Text(HelperFunctions.getInitials(announcement.fromUserName ?? "A B")),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(

            ),
            Text("${MyDateUtil.getMessageTime(context: context, time: announcement.time??"0")}"),
          ],
        ),

      ),
    );
  }
   String truncateDescription(String content) {
    return content.length > 50 ? content.substring(0, 50) + '... ' : content;
  }
}
