import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../helper_functions/function.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.theme['secondaryColor'],
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 1),
        title: Text("User Name",style: TextStyle(color: AppColors.theme['tertiaryColor'],fontWeight: FontWeight.bold),),
        subtitle: Text(truncateDescription("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")),
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.theme['secondaryBgColor'],
          child: Text("H"),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(

            ),
            Text("Time here"),
          ],
        ),

      ),
    );
  }
   String truncateDescription(String content) {
    return content.length > 50 ? content.substring(0, 50) + '... ' : content;
  }
}
