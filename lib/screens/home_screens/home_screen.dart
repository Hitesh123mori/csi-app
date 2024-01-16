import 'package:csi_app/screens/home_screens/more.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import '../../providers/bottom_navigation_provider.dart';
import 'ask_doubts.dart';
import 'event_calendart.dart';
import 'posts_screen.dart';
import 'upcoming_events.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

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
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            elevation: 0,
            shadowColor: AppColors.theme['primaryColor'],
            backgroundColor: AppColors.theme['secondaryColor'],
            centerTitle: true,
            title: Text(value.current,style: TextStyle(color:AppColors.theme['tertiaryColor'],fontWeight: FontWeight.bold,fontSize: 18),),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.theme['primaryColor'],
                  child: Icon(Icons.person_outline, color:AppColors.theme['secondaryColor']),
                ),
              )
            ],
          ),
            backgroundColor:AppColors.theme['secondaryColor'],
            bottomNavigationBar: isKeyboardOpen ? null :Material(
              elevation: 10,
              shadowColor: Colors.black,
              child: SafeArea(
                child: Container(
                  color: AppColors.theme['secondaryColor'],
                  height: 80,
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                      child: GNav(
                        haptic:false,
                        onTabChange: (index){
                          if(index==0)
                            setState(() {
                              value.updateCurrent('Home') ;
                            });
                          if(index==1)
                            setState(() {
                              value.updateCurrent('Upcoming Events') ;
                            });
                          if(index==2)
                            setState(() {
                              value.updateCurrent('Doubt Section') ;
                            });
                          if(index==3)
                            setState(() {
                              value.updateCurrent('Calendar') ;
                            });
                          if(index==4)
                            setState(() {
                              value.updateCurrent('More Options') ;
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
                            icon: Icons.chat,
                            iconActiveColor:AppColors.theme['secondaryColor'],
                            text: "Doubt",
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
                          GButton(
                            icon: Icons.more_horiz_outlined,
                            iconActiveColor:AppColors.theme['secondaryColor'],
                            text: "More",
                            iconColor:AppColors.theme['primaryColor'] ,
                            textColor: AppColors.theme['secondaryColor'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if(value.current == 'Home')
                    PostsScreen(),
                  if(value.current == 'Upcoming Events')
                    UpcomingEvents(),
                  if(value.current == 'Calendar')
                    EventCal(),
                  if(value.current == 'Doubt Section')
                     DoubtSection(),
                  if(value.current == 'More Options')
                     MoreScreen(),
                ],
              ),
            )
        ) ;
      }
    );
  }
}
