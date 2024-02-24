import 'package:flutter/material.dart';


class AcadCalendar extends StatefulWidget {
  const AcadCalendar({super.key});

  @override
  State<AcadCalendar> createState() => _AcadCalendarState();
}

class _AcadCalendarState extends State<AcadCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Calendar"),
      ),
    );
  }
}
