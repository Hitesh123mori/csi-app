import 'package:csi_app/apis/FirebaseAPIs.dart';
import 'package:csi_app/apis/StorageAPIs/StorageAPI.dart';
// import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:flutter/material.dart';

// import 'package:csi_app/constants/dummy_post.dart';
import 'package:csi_app/main.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/posting/post_card.dart';

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
    return Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, BottomToTop(AddPostScreen()));
          },
          child: Icon(Icons.add,color: AppColors.theme['secondaryColor'],),
          backgroundColor: AppColors.theme['primaryColor'],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical:5),
            // child: ListView.builder(
            //   physics: BouncingScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: posts.length,
            //   itemBuilder: (context, index) {
            //     print("#l${posts.length}");
            //     return PostCard(
            //       post: posts[index],
            //     );
            //   },
            // ),

            child: StreamBuilder(
              stream: FirebaseAPIs.rtdbRef.child("post").onValue,
              builder: (context, snap) {
                if (snap.hasData) {
                  Map<dynamic, dynamic>? val = snap.data?.snapshot.value as Map<dynamic, dynamic>?;
                  if (val == null || val.isEmpty) {
                    return Center(
                      child: Text("No posts"),
                    );
                  } else {
                    List<Post> posts = [];
                    val.forEach((key, value) {
                      posts.add(Post.fromJson(value));
                    });
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
                  print("#error-postScreen: ${snap.error.toString()}");
                  return Text("${snap.error.toString()}");
                } else {
                  return PostShimmerEffect();
                }
              },
            )
        )
    );
  }
}