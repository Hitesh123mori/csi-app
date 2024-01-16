import 'package:flutter/material.dart' ;

import '../../utils/colors.dart';


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
            "Past Activities",
            style: TextStyle(
                color: AppColors.theme['tertiaryColor'],
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        body: Center(
          child: Text("Past Event lists and all details"),
        ),
      ),
    );
  }
}
