import 'package:csi_app/utils/widgets/posting/post_card.dart';
import 'package:flutter/material.dart';

import '../../constants/dummy_post.dart';
import '../../main.dart';
import '../../utils/colors.dart';

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
          onPressed: (){},
          child: Icon(Icons.add,color: AppColors.theme['secondaryColor'],),
          backgroundColor: AppColors.theme['primaryColor'],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical:5),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              print("#l${posts.length}");
              return PostCard(
                post: posts[index],
              );
            },
          ),
        )
        );
  }
}
