import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class BlogsCSI extends StatefulWidget {
  const BlogsCSI({super.key});

  @override
  State<BlogsCSI> createState() => _BlogsCSIState();
}

class _BlogsCSIState extends State<BlogsCSI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          elevation: 0.3,
          shadowColor: AppColors.theme['primaryColor'],
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon : Icon(Icons.keyboard_arrow_left_sharp,size: 32,),

          ),
          title: Text(
            "Blogs",
            style: TextStyle(
                color: AppColors.theme['tertiaryColor'],
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        body: Center(
          child: Text("Blogs"),
        ),
      ),
    );
  }
}
