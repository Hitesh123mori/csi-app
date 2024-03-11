import 'package:csi_app/apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/GeneralAPIs.dart';
import 'package:csi_app/models/user_model/post_creator.dart';
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
  final Map<String, Color> rankColors = {
    'newbie': Color(0xFF808080),
    'pupil': Color(0xFF03A89E),
    'specialist': Color(0xFF3182CE),
    'expert': Color(0xFF7C3AED),
    'candidate master': Color(0xFFE47272),
    'master': Color(0xFFE47272),
    'international master': Color(0xFFE47272),
    'grandmaster': Color(0xFFFF8C00),
    'international grandmaster': Color(0xFFFF8C00),
    'legendary grandmaster': Color(0xFFFF8C00),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserProvider>(builder: (context, appUserProvider, child) {
      // appUserProvider.initUser();
      print("#user ${appUserProvider.user?.cfId}");

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          appBar: AppBar(
            surfaceTintColor: AppColors.theme['secondaryColor'],
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.theme['tertiaryColor']),
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
            onPressed: () async {
              await appUserProvider.logOut().then((value) => Navigator.pushReplacement(context, RightToLeft(LoginScreen())));
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                PostCreatorCard(
                  postCreator: PostCreator(
                    about: "Sample About",
                    email: "example@example.com",
                    name: "John Doe",
                    nuRoll: "789",
                    year: "2024",
                    profilePhotoUrl: "", // Profile image is empty for this example
                  ),
                ),
                StreamBuilder(
                  stream: CFGeneralAPIs.fetchCodeforcesUserProfile(appUserProvider.user?.cfId ?? ""),
                  builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userProfile = snapshot.data!;
                      return Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.theme['secondaryBgColor'], AppColors.theme['secondaryColor']],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProfile['handle'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: rankColors[userProfile['rank']] ?? AppColors.theme['tertiaryColor'],
                                  ),
                                ),
                                SizedBox(height: 20),
                                _buildProfileInfo('Rating', '${userProfile['rating']}', Icons.stars, AppColors.theme['tertiaryColor']),
                                SizedBox(height: 10),
                                _buildProfileInfo('Rank', '${userProfile['rank']}', Icons.trending_up, AppColors.theme['tertiaryColor']),
                                SizedBox(height: 10),
                                _buildProfileInfo('Max Rating', '${userProfile['maxRating']}', Icons.emoji_events, AppColors.theme['tertiaryColor']),
                                SizedBox(height: 10),
                                _buildProfileInfo('Max Rank', '${userProfile['maxRank']}', Icons.star, AppColors.theme['tertiaryColor']),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileInfo(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 10),
        Text(
          '$label:',
          style: TextStyle(fontSize: 18, color: color),
        ),
        SizedBox(width: 5),
        Text(
          value,
          softWrap: true,
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }

  String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String initials = "";

    int numWords = nameSplit.length > 2 ? 2 : nameSplit.length;

    for (int i = 0; i < numWords; i++) {
      initials += nameSplit[i][0];
    }

    return initials.toUpperCase();
  }
}

class PostCreatorCard extends StatefulWidget {
  final PostCreator postCreator;

  const PostCreatorCard({Key? key, required this.postCreator}) : super(key: key);

  @override
  _PostCreatorCardState createState() => _PostCreatorCardState();
}

class _PostCreatorCardState extends State<PostCreatorCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.theme["primaryColor"], AppColors.theme["primaryColor"].withOpacity(0.5)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.theme["primaryColor"].withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                getInitials(widget.postCreator.name ?? ""),
                style: TextStyle(
                  color: AppColors.theme["primaryColor"],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              widget.postCreator.name ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  'About: ${widget.postCreator.about ?? ""}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 2),
                Text(
                  'Email: ${widget.postCreator.email ?? ""}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 2),
                Text(
                  'NU Roll: ${widget.postCreator.nuRoll ?? ""}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 2),
                Text(
                  'Year: ${widget.postCreator.year ?? ""}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String initials = "";

    int numWords = nameSplit.length > 2 ? 2 : nameSplit.length;

    for (int i = 0; i < numWords; i++) {
      initials += nameSplit[i][0];
    }

    return initials.toUpperCase();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
