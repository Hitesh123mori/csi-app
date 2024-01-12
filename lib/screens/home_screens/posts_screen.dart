import 'package:flutter/material.dart';

import '../../main.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height*0.34,horizontal: mq.width*0.45),
      child: Text("Posts",style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
