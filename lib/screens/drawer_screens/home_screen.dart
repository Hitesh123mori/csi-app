import 'package:csi_app/screens/providers/drawer_option_provider.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import '../home_screens/ask_doubts.dart';
import '../home_screens/event_calendart.dart';
import '../home_screens/posts_screen.dart';
import '../home_screens/upcoming_events.dart';
import '../providers/bottom_navigation_provider.dart';

class HomeScreen extends StatefulWidget {
  final DrawerOptionProvider drawerOp ;
  const HomeScreen({super.key, required this.drawerOp});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Consumer<BottomNavigationProvider>(
      builder: (context,value,child){
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
                            value.updateCurrent('isHomeTab') ;
                          });
                        if(index==1)
                          setState(() {
                            value.updateCurrent('isUpcomeEventTab') ;
                          });
                        if(index==2)
                          setState(() {
                            value.updateCurrent('isAskTab') ;
                          });
                        if(index==3)
                          setState(() {
                            value.updateCurrent('isEventCalTab') ;
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
                  if(value.current == 'isHomeTab')
                    PostsScreen(),
                  if(value.current == 'isUpcomeEventTab')
                    UpcomingEvents(),
                  if(value.current == 'isEventCalTab')
                    DoubtSection(),
                  if(value.current == 'isAskTab')
                    EventCal(),
                ],
              ),
            )
        ) ;
      }
    );
  }
}
