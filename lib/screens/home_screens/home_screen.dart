import 'package:csi_app/screens/home_screens/more.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../providers/bottom_navigation_provider.dart';
import '../../side_transition_effects/right_left.dart';
import 'calendar.dart';
import 'upcoming_events.dart';
import 'notifications.dart';
import 'posting/posts_screen.dart';
import 'upcoming_events.dart';

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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<BottomNavigationProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          elevation: 0,
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,
          title: value.current == "Home"
              ? SafeArea(
                  child: Container(
                    height: 45,
                    constraints: BoxConstraints(
                        minWidth: 200, maxWidth: 250, maxHeight: 50),
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
                        style: TextStyle(color: Colors.black,fontSize: 16),
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
                    value.current,
                    style: TextStyle(
                        color: AppColors.theme['tertiaryColor'],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(Icons.person_outline,
                  color: AppColors.theme['tertiaryColor'],size: 25,),
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
                            value.updateCurrent('Home');
                            screenname = PostsScreen();
                          });
                        if (index == 1)
                          setState(() {
                            value.updateCurrent('Upcoming');
                            screenname = UpcomingEvents();
                          });
                        if (index == 2)
                          setState(() {
                            value.updateCurrent('Calendar');
                            screenname = AcadCalendar();
                          });
                        if (index == 3)
                          setState(() {
                            value.updateCurrent('More Options');
                            screenname = MoreScreen();
                          });
                      },
                      gap: 5,
                      padding: EdgeInsets.all(12),
                      backgroundColor:AppColors.theme['secondaryColor'] ,
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
                          icon: Icons.chat,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "Upcoming",
                          iconColor: AppColors.theme['primaryColor'],
                          textColor: AppColors.theme['secondaryColor'],
                        ),
                        GButton(
                          icon: Icons.event_available_sharp,
                          iconActiveColor: AppColors.theme['secondaryColor'],
                          text: "Calendar",
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
