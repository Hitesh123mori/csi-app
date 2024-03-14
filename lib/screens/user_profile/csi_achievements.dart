import 'package:flutter/material.dart' ;

import '../../utils/colors.dart';


class CsiAchievements extends StatefulWidget {
  const CsiAchievements({super.key});

  @override
  State<CsiAchievements> createState() => _CsiAchievementsState();
}

class _CsiAchievementsState extends State<CsiAchievements> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor : AppColors.theme['secondaryColor'],
        body: Center(child: Text("No Achievements")),
      ),
    );
  }
}
