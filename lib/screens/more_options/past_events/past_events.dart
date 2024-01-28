import 'package:csi_app/utils/widgets/event_card/event_card.dart';
import 'package:flutter/material.dart';
import '../../../constants/event_list.dart';
import '../../../main.dart';
import '../../../models/event_model/event.dart';
import '../../../models/event_model/event_yearwise.dart';
import '../../../utils/colors.dart';

class PastEvent extends StatefulWidget {
  const PastEvent({Key? key}) : super(key: key);

  @override
  State<PastEvent> createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {
  List<EventYear> eventYears = eventyearwise;

  String selectedYear = '2023';
  List<Event> selectedEvents = [];

  @override
  void initState() {
    super.initState();
    selectedEvents = getEventsForYear(selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    print("#EnterPastEventScreen");
    mq = MediaQuery.of(context).size;
    return  Scaffold(
        backgroundColor: AppColors.theme['secondaryColor'],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 32,
            ),
          ),
          title: Text(
            "Past Events",
            style: TextStyle(
              color: AppColors.theme['tertiaryColor'],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
          child: Column(
            children: [
              buildDropdown(),
              SizedBox(height: 20),
              Expanded(child: buildEventList(selectedEvents)),
            ],
          ),
        ),
      );
  }

  Widget buildDropdown() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: mq.width*0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Events $selectedYear',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.theme['tertiaryColor'],
            ),
          ),
          DropdownButton<String>(
            value: selectedYear,
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue!;
                selectedEvents = getEventsForYear(selectedYear);
              });
            },
            style: TextStyle(color: AppColors.theme['secondaryColor']),
            items: eventYears
                .map<DropdownMenuItem<String>>((EventYear eventYear) {
              return DropdownMenuItem<String>(
                value: eventYear.year,
                child: Text(
                  eventYear.year,
                  style: TextStyle(
                    color: AppColors.theme['tertiaryColor'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            dropdownColor: AppColors.theme['secondaryColor'],
          ),
        ],
      ),
    );
  }

  List<Event> getEventsForYear(String year) {
    for (var eventYear in eventYears) {
      if (eventYear.year == year) {
        return eventYear.events;
      }
    }
    return [];
  }

  Widget buildEventList(List<Event> events) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        print("#l${events.length}");
        return EventCard(
          event: events[index],
          onTap: (){},
        );
      },
    );
  }
}
