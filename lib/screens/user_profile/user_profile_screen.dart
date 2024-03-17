import 'package:csi_app/apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/CFGeneralAPIs.dart';
import 'package:csi_app/models/user_model/post_creator.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/screens/auth_sceens/login_screen.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../side_transition_effects/left_right.dart';
import '../../side_transition_effects/right_left.dart';
import '../../utils/colors.dart';
import '../home_screens/home_screen.dart';
import 'basic_info.dart';
import 'codeforces_view.dart';
import 'csi_achievements.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
        builder: (context, appUserProvider, child) {
      // appUserProvider.initUser();
      print("#user ${appUserProvider.user?.cfId}");
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: AppColors.theme['secondaryColor'],
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
              backgroundColor: AppColors.theme['primaryColor'],
              child: Icon(
                Icons.logout,
                color: AppColors.theme['secondaryColor'],
              ),
              onPressed: () async {
                await appUserProvider.logOut().then((value) =>
                    Navigator.pushReplacement(
                        context, RightToLeft(LoginScreen())));
              },
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    surfaceTintColor: AppColors.theme['secondaryColor'],
                    color: AppColors.theme['secondaryColor'],
                    // color: AppColors.theme['secondaryBgColor'],
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        appUserProvider.user?.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        appUserProvider.user?.about ?? "",
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        child: Text(
                          HelperFunctions.getInitials(appUserProvider.user?.name ?? ""),
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.theme['secondaryColor'],
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: AppColors.theme["primaryColor"],
                      ),
                      contentPadding: EdgeInsets.only(left: 5),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, LeftToRight(BasicInfo()));
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    physics: BouncingScrollPhysics(),
                    labelColor: AppColors.theme['primaryColor'],
                    indicatorColor: AppColors.theme['primaryColor'],
                    tabs: [
                      Tab(text: 'Codeforces'),
                      Tab(text: 'Achievements'),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: mq.height * 0.8,
                            child: TabBarView(
                              children: [
                                CodeforcesView(),
                                CsiAchievements(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }


}

// extra code

// class PostCreatorCard extends StatefulWidget {
//   final PostCreator postCreator;
//
//   const PostCreatorCard({Key? key, required this.postCreator})
//       : super(key: key);
//
//   @override
//   _PostCreatorCardState createState() => _PostCreatorCardState();
// }
//
// class _PostCreatorCardState extends State<PostCreatorCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
//     _animationController.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _animation,
//       child: ScaleTransition(
//         scale: _animation,
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 AppColors.theme["primaryColor"],
//                 AppColors.theme["primaryColor"].withOpacity(0.5)
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.theme["primaryColor"].withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: ListTile(
//             contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 getInitials(widget.postCreator.name ?? ""),
//                 style: TextStyle(
//                   color: AppColors.theme["primaryColor"],
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//             title: Text(
//               widget.postCreator.name ?? '',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 4),
//                 Text(
//                   'About: ${widget.postCreator.about ?? ""}',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'Email: ${widget.postCreator.email ?? ""}',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'NU Roll: ${widget.postCreator.nuRoll ?? ""}',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'Year: ${widget.postCreator.year ?? ""}',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String getInitials(String name) {
//     List<String> nameSplit = name.split(" ");
//     String initials = "";
//
//     int numWords = nameSplit.length > 2 ? 2 : nameSplit.length;
//
//     for (int i = 0; i < numWords; i++) {
//       initials += nameSplit[i][0];
//     }
//
//     return initials.toUpperCase();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
