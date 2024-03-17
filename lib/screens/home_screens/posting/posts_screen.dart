import 'dart:developer';

import 'package:csi_app/apis/FirebaseAPIs.dart';
// import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:flutter/material.dart';

// import 'package:csi_app/constants/dummy_post.dart';
import 'package:csi_app/main.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/posting/post_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/shimmer_effects/post_screen_shimmer_effect.dart';
import 'add_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
      builder: (context, appUserProvider, child) {
        if (appUserProvider.user == null)
          return Scaffold(
            body: Text("Something went wrong"),
          );
        return Scaffold(
            backgroundColor: AppColors.theme['backgroundColor'],
            floatingActionButton: (appUserProvider.user?.isAdmin ?? false) || (appUserProvider.user?.isSuperuser ?? false)
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, BottomToTop(AddPostScreen()));
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.theme['secondaryColor'],
                    ),
                    backgroundColor: AppColors.theme['primaryColor'],
                  )
                : null,
            body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: StreamBuilder(
                  stream: FirebaseAPIs.rtdbRef.child("post").onValue,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      Map<dynamic, dynamic>? val = snap.data?.snapshot.value as Map<dynamic, dynamic>?;
                      if (val == null || val.isEmpty) {
                        return Center(
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/no_item.png",
                                  height: 200,
                                  width: 200,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                                  child: Text(
                                    "No Items",
                                    style: TextStyle(
                                        color: AppColors.theme['disableButtonColor'],
                                        fontSize: 25),
                                  ),
                                ),
                              ]),
                        );
                      } else {
                        List<Post> posts = [];
                        val.forEach((key, value) {
                          log("#key : $key");
                          posts.add(Post.fromJson(value));
                        });
                        posts.sort((a, b) => b.compareTo(a));

                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              post: posts[index],
                            );
                          },
                        );
                      }
                    } else if (snap.hasError) {
                      log("#error-postScreen: ${snap.error.toString()}");
                      return Text("${snap.error.toString()}");
                    } else {
                      return PostShimmerEffect();
                    }
                  },
                )));
      },
    );
  }
}
