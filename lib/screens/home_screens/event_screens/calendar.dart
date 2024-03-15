import 'package:csi_app/screens/home_screens/event_screens/upcoming_events.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/event_model/event_model.dart';


class AcadCalendar extends StatefulWidget {
  const AcadCalendar({super.key});

  @override
  State<AcadCalendar> createState() => _AcadCalendarState();
}

class _AcadCalendarState extends State<AcadCalendar> {

  List<CSIEvent> events = [];
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.theme['primaryColor'],
        onPressed: (){

        },
        child: Icon(Icons.add,size: 32,color: AppColors.theme['secondaryColor'],),
      ),
      body: Column(
        children: [
        SfCalendar(
          todayHighlightColor: AppColors.theme['primaryColor'],
          backgroundColor: AppColors.theme['secondaryBgColor'],
          cellBorderColor: AppColors.theme['primaryColor'],
        view: CalendarView.month,
      ),


        ],
      )
    );
  }
}
