import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/screens/home_screens/more/all_admins.dart';
import 'package:csi_app/screens/home_screens/more/announcement_screen.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/more_menu_card/more_menu_item.dart';
import 'all_users.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
        builder: (context, appUserProvider, child) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // for all members
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: mq.width * 0.05, top: 20, bottom: 10),
                  child: Text(
                    "More",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.theme['primaryColor']),
                  ),
                ),
                Moremenuitems(
                  text: 'Blogs',
                  onTap: () {
                    HelperFunctions.launchURL('https://csi-nirma.vercel.app');
                  },
                  icon: Icon(
                    Icons.post_add_sharp,
                    size: 25,
                    color: AppColors.theme['primaryColor'],
                  ),
                ),
                Moremenuitems(
                  text: 'Board Members',
                  onTap: () {
                    HelperFunctions.launchURL(
                        'https://csi-nirma.vercel.app/board');
                  },
                  icon: Icon(
                    Icons.group,
                    size: 25,
                    color: AppColors.theme['primaryColor'],
                  ),
                ),
                Moremenuitems(
                  text: 'Past Events and sessions',
                  onTap: () {
                    HelperFunctions.launchURL('https://csi-nirma.vercel.app/');
                  },
                  icon: Icon(
                    Icons.event_note_sharp,
                    size: 25,
                    color: AppColors.theme['primaryColor'],
                  ),
                ),
              ],
            ),

            // for admins and superuser
            if ((appUserProvider.user?.isSuperuser ?? false) ||
                (appUserProvider.user?.isAdmin ?? false))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: mq.width * 0.05, top: 20, bottom: 10),
                    child: Text(
                      "Admin Control",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.theme['primaryColor']),
                    ),
                  ),
                  Moremenuitems(
                      text: "Users",
                      onTap: () {
                        Navigator.push(context, LeftToRight(AllUsers()));
                      },
                      icon: Icon(
                        Icons.people_outline_rounded,
                        size: 25,
                        color: AppColors.theme['primaryColor'],
                      )
                  ),
                  Moremenuitems(
                      text: "Admins",
                      onTap: () {
                        Navigator.push(context, LeftToRight(AllAdmins()));
                      },
                      icon: Icon(
                        Icons.people_outline_rounded,
                        size: 25,
                        color: AppColors.theme['primaryColor'],
                      )
                  ),
                  Moremenuitems(
                      text: "Announcement",
                      onTap: () {
                        Navigator.push(context, LeftToRight(AnnouncementScreen()));
                      },
                      icon: Icon(
                        Icons.announcement_outlined,
                        size: 25,
                        color: AppColors.theme['primaryColor'],
                      )
                  ),

                ],
              )
          ],
        ),
      );
    });
  }
}
