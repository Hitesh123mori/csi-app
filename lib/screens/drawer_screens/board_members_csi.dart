import 'package:flutter/material.dart' ;


class BoardMemberCSI extends StatefulWidget {
  const BoardMemberCSI({super.key});

  @override
  State<BoardMemberCSI> createState() => _BoardMemberCSIState();
}

class _BoardMemberCSIState extends State<BoardMemberCSI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Board Members"),
        ),
      ),
    );
  }
}
