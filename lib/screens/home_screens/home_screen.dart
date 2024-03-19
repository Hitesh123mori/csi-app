import 'dart:developer';

import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/screens/home_screens/more/more.dart';
import 'package:csi_app/screens/user_profile/codeforces_view.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/ProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/CFGeneralAPIs.dart';
import '../../apis/notification_apis/notifications_api.dart';
import '../../main.dart';
import '../../providers/bottom_navigation_provider.dart';
import '../../side_transition_effects/left_right.dart';
import '../../side_transition_effects/right_left.dart';
import '../user_profile/user_profile_screen.dart';
import 'event_screens/codeforrces_problem_set.dart';
import 'event_screens/upcoming_events.dart';
import 'notifications.dart';
import 'posting/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget screenname = PostsScreen();



  final FocusNode _focusNode = FocusNode();
  bool _isFirst = true;





  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future initUser(AppUserProvider appUserProvider) async {
    await appUserProvider.initUser();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer2<BottomNavigationProvider, AppUserProvider>(builder: (context, bottomNavProvider, appUserProvider, child) {
      if (_isFirst){
        initUser(appUserProvider);
        _isFirst = false;
      }
      log("#user :  ${appUserProvider.user?.name}");
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          elevation: 0,
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,
          title: bottomNavProvider.current == "Home"
              ? SafeArea(
                  child: Container(
                    height: 45,
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 250, maxHeight: 50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.theme['secondaryBgColor'],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        cursorColor: AppColors.theme['tertiaryColor'],
                        autocorrect: true,
                        focusNode: _focusNode,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search posts",
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Text(
                    bottomNavProvider.current,
                    style: TextStyle(color: AppColors.theme['tertiaryColor'], fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () async{
                log("#app ${appUserProvider.user?.name}");
                if (appUserProvider.user != null) {
                  Navigator.push(context, LeftToRight(UserProfileScreen()));
                }
              },
              child: ProfilePhoto(url: appUserProvider.user?.profilePhotoUrl, name: appUserProvider.user?.name, radius: 40, isHomeScreen: true,)
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    size: 25,
                    color: AppColors.theme['tertiaryColor'],
                  ),
                  onPressed: () {
                    // NotificationApi.getNotification(appUserProvider.user?.userID ?? "");
                    Navigator.push(context, RightToLeft(Notifications()));
                  },
                ))
          ],
        ),
        backgroundColor: AppColors.theme['backgroundColor'],
        bottomNavigationBar: isKeyboardOpen
            ? null
            : Material(
                color: AppColors.theme['secondaryColor'],
                elevation: 5,
                shadowColor: Colors.black,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: GNav(
                      haptic: true,
                      onTabChange: (index) {
                        if (index == 0)
                          setState(() {
                            bottomNavProvider.updateCurrent('Home');
                            screenname = PostsScreen();
                          });
                        if (index == 1)
                          setState(() {
                            bottomNavProvider.updateCurrent('Upcoming');
                            screenname = UpcomingEvents();
                          });
                        if (index == 2)
                          setState(() {
                            bottomNavProvider.updateCurrent('Problems');
                            screenname = CodefocesProblems();
                          });
                        if (index == 3)
                          setState(() {
                            bottomNavProvider.updateCurrent('More Options');
                            screenname = MoreScreen();
                          });
                      },
                      gap: 5,
                      padding: EdgeInsets.all(12),
                      backgroundColor: AppColors.theme['secondaryColor'],
                      tabBackgroundColor: AppColors.theme['primaryColor'],
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "Home",
                          iconColor: AppColors.theme['primaryColor'],
                          textColor: AppColors.theme['secondaryColor'],
                        ),
                        GButton(
                          icon: Icons.event,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "Upcoming",
                          iconColor: AppColors.theme['primaryColor'],
                          textColor: AppColors.theme['secondaryColor'],
                        ),
                        GButton(
                          icon: Icons.code,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "Problems",
                          iconColor: AppColors.theme['primaryColor'],
                          textColor: AppColors.theme['secondaryColor'],
                        ),
                        GButton(
                          icon: Icons.more_horiz_outlined,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "More",
                          iconColor: AppColors.theme['primaryColor'],
                          textColor: AppColors.theme['secondaryColor'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        body: screenname,
      );
    });
  }
}
