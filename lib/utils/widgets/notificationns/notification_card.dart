import 'package:csi_app/models/notification_model/Announcement.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper_functions/function.dart';

class NotificationCard extends StatelessWidget {
  Announcement announcement;
  NotificationCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: AppColors.theme['secondaryColor'],
        child: ListTile(
          onTap: (){
            Navigator.push(context, LeftToRight(ExpandNotificationScreen(announcement: announcement,)));
          },
          contentPadding: EdgeInsets.only(right: 1),
          title: Text(
            "${announcement.fromUserName}",
            style: TextStyle(
                color: AppColors.theme['tertiaryColor'],
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(truncateDescription(HelperFunctions.base64ToString(announcement.message ?? ""))),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.theme['secondaryBgColor'],
              child: Text(
                  announcement.fromUserName?[0] ?? "",
              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text("${MyDateUtil.getMessageTime(context: context, time: announcement.time ?? "0")}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String truncateDescription(String content) {
    return content.length > 30 ? content.substring(0, 30) + '... ' : content;
  }
}




class ExpandNotificationScreen extends StatefulWidget {
  final Announcement announcement;
  const ExpandNotificationScreen({super.key, required this.announcement});

  @override
  State<ExpandNotificationScreen> createState() => _ExpandNotificationScreenState();
}

class _ExpandNotificationScreenState extends State<ExpandNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['secondaryColor'],
        appBar : AppBar(
          elevation: 0.4,
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
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
            child: Container(
              color: AppColors.theme['secondaryColor'],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:[
                   buildContent(HelperFunctions.base64ToString(widget.announcement.message ?? ""))
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(String content) {
    List<InlineSpan> children = [];

    RegExp regex = RegExp(r'https?://\S+');
    Iterable<RegExpMatch> matches = regex.allMatches(content);

    int currentIndex = 0;

    for (RegExpMatch match in matches) {
      String url = match.group(0)!;
      int start = match.start;
      int end = match.end;

      children.add(TextSpan(text: content.substring(currentIndex, start)));

      children.add(
        TextSpan(
          text: url,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              HelperFunctions.launchURL(url);
            },
        ),
      );

      currentIndex = end;
    }

    children.add(TextSpan(text: content.substring(currentIndex)));

    return RichText(
        text: TextSpan(
          children: children,
          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontSize: 18,fontWeight: FontWeight.bold),
        ));
  }

}
