import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/screens/auth_sceens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../side_transition_effects/right_left.dart';
import '../../utils/colors.dart';
import '../home_screens/home_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserProvider>(
        builder: (context, appUserProvider, child) {
          appUserProvider.initUser();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          appBar: AppBar(
            surfaceTintColor: AppColors.theme['secondaryColor'],
            title: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.theme['tertiaryColor']),
            ),
            backgroundColor: AppColors.theme['secondaryColor'],
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, RightToLeft(HomeScreen()));
              },
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 32,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              await appUserProvider.logOut().then((value) => Navigator.pushReplacement(context, RightToLeft(LoginScreen())));
            },
          ),
          body: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.theme['secondaryBgColor'],
                  child: Center(
                      child: Text(
                        (appUserProvider.user?.name?[0].toUpperCase()) ?? "",
                        style: TextStyle(
                            color: AppColors.theme['tertiaryColor'],
                            fontWeight: FontWeight.bold),
                      )),
                ),
                title: Text(
                 appUserProvider.user?.name ?? "",
                  style: TextStyle(
                      color: AppColors.theme['tertiaryColor'],
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  appUserProvider.user?.about ?? "",
                  style: TextStyle(
                      color: AppColors.theme['tertiaryColor'],
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
