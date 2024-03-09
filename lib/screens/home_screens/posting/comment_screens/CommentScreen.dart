import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/posting/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:csi_app/side_transition_effects/TopToBottom.dart';
import 'package:csi_app/screens/home_screens/posting/posts_screen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, value, child) {
        return MaterialApp(
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
                  Navigator.push(context, TopToBottom(HomeScreen()));
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 32,
                ),
              ),
            ),

            body: SafeArea(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          PostCard(post: value.post!),
                        ],
                      ),


                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      TextFormField(),
                      Icon(Icons.send, size: 15,)
                    ],
                  ),
                ),

              ]),
            ),
          ),
        );
      },
    );
  }
}
