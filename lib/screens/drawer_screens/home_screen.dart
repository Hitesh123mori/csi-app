import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import '../home_screens/ask_doubts.dart';
import '../home_screens/event_calendart.dart';
import '../home_screens/posts_screen.dart';
import '../home_screens/upcoming_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isHomeTab = true ;
  bool isUpcomeEventTab = false ;
  bool isEventCalTab = false ;
  bool isAskTab = false ;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Scaffold(
          backgroundColor:AppColors.theme['secondaryColor'],
        bottomNavigationBar: isKeyboardOpen ? null :Material(
          elevation: 10,
          shadowColor: Colors.black,
          child: Container(
            height: 80,
            child: Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                child: GNav(
                  haptic:false,
                  onTabChange: (index){
                    if(index==0)
                      setState(() {
                        isHomeTab = true ;
                         isUpcomeEventTab = false ;
                        isEventCalTab = false ;
                         isAskTab = false ;
                      });
                    if(index==1)
                      setState(() {
                        isHomeTab = false ;
                        isUpcomeEventTab = true ;
                        isEventCalTab = false ;
                        isAskTab = false ;
                      });
                    if(index==2)
                      setState(() {
                        isHomeTab = false ;
                        isUpcomeEventTab = false ;
                        isEventCalTab = false ;
                        isAskTab = true ;
                      });
                    if(index==3)
                      setState(() {
                        isHomeTab = false ;
                        isUpcomeEventTab = false ;
                        isEventCalTab = true ;
                        isAskTab = false ;
                      });
                  },
                  gap: 8,
                  padding: EdgeInsets.all(12),
                 tabBackgroundColor: AppColors.theme['primaryColor'],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      iconActiveColor:AppColors.theme['secondaryColor'],
                      text: "Home",
                      iconColor:AppColors.theme['primaryColor'] ,
                      textColor: AppColors.theme['secondaryColor'],
                    ),
                    GButton(
                      icon: Icons.event_available,
                      iconActiveColor:AppColors.theme['secondaryColor'],
                      text: "Events",
                      iconColor:AppColors.theme['primaryColor'] ,
                      textColor: AppColors.theme['secondaryColor'],
                    ),
                    GButton(
                      icon: Icons.help,
                      iconActiveColor:AppColors.theme['secondaryColor'],
                      text: "Ask",
                      iconColor:AppColors.theme['primaryColor'] ,
                      textColor: AppColors.theme['secondaryColor'],
                    ),
                    GButton(
                      icon: Icons.calendar_today_sharp,
                      iconActiveColor:AppColors.theme['secondaryColor'],
                      text: "Calendar",
                      iconColor:AppColors.theme['primaryColor'] ,
                      textColor: AppColors.theme['secondaryColor'],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if(isHomeTab)
                PostsScreen(),
              if(isUpcomeEventTab)
                 UpcomingEvents(),
              if(isAskTab)
                DoubtSection(),
              if(isEventCalTab)
                EventCal(),
            ],
          ),
        )
      );
  }
}
