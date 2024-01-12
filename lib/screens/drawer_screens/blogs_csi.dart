import 'package:flutter/material.dart' ;

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
        body: Center(
      child: Text("Blogs"),
     ),
      ),
    );
  }
}
