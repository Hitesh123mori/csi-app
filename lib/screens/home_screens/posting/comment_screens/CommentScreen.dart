import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../side_transition_effects/TopToBottom.dart';
import '../posts_screen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, value, child){
        return MaterialApp(
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.theme['primaryColor'],
                selectionColor:
                AppColors.theme['primaryColor'].withOpacity(0.2),
                selectionHandleColor:
                AppColors.theme['secondaryBgColor'].withOpacity(0.2),
              )),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              surfaceTintColor: AppColors.theme['secondaryColor'],
              title: Text(
                "Comments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColors.theme['secondaryColor'],
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context, TopToBottom(PostsScreen()));
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 32,
                ),
              ),

            ),
          ),
        );
      },
    );
  }
}
