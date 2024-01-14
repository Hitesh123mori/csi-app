import 'package:csi_app/screens/drawer_screens/blogs_csi.dart';
import 'package:csi_app/screens/providers/drawer_option_provider.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import '../main.dart';
import 'drawer_screens/about_csi.dart';
import 'drawer_screens/board_members_csi.dart';
import 'drawer_screens/home_screen.dart';
import 'drawer_screens/past_events.dart';
import 'drawer_screens/speaker_sessions.dart';


class DrawerScreen extends StatefulWidget {
  final DrawerOptionProvider drawerOp ;
  const DrawerScreen({Key? key, required this.drawerOp}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<ScreenHiddenDrawer> _pages = [];
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isKeyboardOpen = _focusNode.hasFocus;
      });
    });
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        HomeScreen(drawerOp: widget.drawerOp,),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Blogs',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        BlogsCSI(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Board Members',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        BoardMemberCSI(drawerOp: widget.drawerOp,),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Past Events',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        PastEvent(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Speaker Sessions',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        SpeakerSession(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'About CSI',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
          colorLineSelected: AppColors.theme['primaryColor'],
        ),
        AboutCSI(),
      ),
    ];
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: HiddenDrawerMenu(
        isTitleCentered: true,
        elevationAppBar: 0,
        actionsAppBar: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.theme['primaryColor'],
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
          )
        ],
        disableAppBarDefault: false,
        withAutoTittleName: true,
        styleAutoTittleName: TextStyle(fontWeight: FontWeight.bold,color: AppColors.theme['tertiaryColor']),
        backgroundColorAppBar: AppColors.theme['secondaryColor'],
        leadingAppBar: Icon(Icons.menu_outlined),
        slidePercent: 45,
        backgroundColorContent: AppColors.theme['secondaryColor'],
        screens: _pages,
        backgroundColorMenu: AppColors.theme['secondaryColor'],
        contentCornerRadius: 10,
      ),
    );
  }


}
