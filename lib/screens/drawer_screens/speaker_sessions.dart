import 'package:flutter/material.dart' ;


class SpeakerSession extends StatefulWidget {
  const SpeakerSession({super.key});

  @override
  State<SpeakerSession> createState() => _SpeakerSessionState();
}

class _SpeakerSessionState extends State<SpeakerSession> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Speaker sessions"),
        ),
      ),
    );
  }
}
