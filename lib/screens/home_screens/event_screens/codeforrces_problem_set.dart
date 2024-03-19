import 'package:csi_app/screens/home_screens/event_screens/upcoming_events.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../models/event_model/event_model.dart';


class CodefocesProblems extends StatefulWidget {
  const CodefocesProblems({super.key});

  @override
  State<CodefocesProblems> createState() => _CodefocesProblemsState();
}

class _CodefocesProblemsState extends State<CodefocesProblems> {

  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
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
                      color: AppColors.theme['tertiaryColor'].withOpacity(0.5),
                      fontSize: 25),
                ),
              ),
            ]),
      ),
    );
  }
}