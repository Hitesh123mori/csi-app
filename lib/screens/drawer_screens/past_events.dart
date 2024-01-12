import 'package:flutter/material.dart' ;


class PastEvent extends StatefulWidget {
  const PastEvent({super.key});

  @override
  State<PastEvent> createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Past Event lists and all details"),
        ),
      ),
    );
  }
}
