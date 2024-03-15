import 'package:csi_app/models/event_model/event_model.dart';
import 'package:csi_app/screens/home_screens/event_screens/add_event_screen.dart';
import 'package:flutter/material.dart' ;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  List<CSIEvent> events = [];
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                EventCalendar(
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                      events = _getEventsForDate(date);
                    });
                  },
                ),
                 SizedBox(height: 20),
                Expanded(
                  child: EventList(events: selectedDate != null ? events : []),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddEventScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<CSIEvent> _getEventsForDate(DateTime? date) {
    if (date == null) {
      return [];
    }
    return events
        .where((event) =>
    event.startTime.year == date.year &&
        event.startTime.month == date.month &&
        event.startTime.day == date.day)
        .toList();
  }

  void _navigateToAddEventScreen(BuildContext context) async {
    final newEvent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(
          onEventAdded: (newEvent) {
            setState(() {
              events.add(newEvent);
            });
          },
        ),
      ),
    );
    if (newEvent != null) {
      setState(() {
        events.add(newEvent);
      });
    }
  }

}


class EventList extends StatelessWidget {
  final List<CSIEvent> events;

  EventList({required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: EventCard(event: events[index]),
        );
      },
    );
  }
}

class EventCalendar extends StatelessWidget {
  final Function(DateTime)? onDateSelected;

  EventCalendar({this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      onTap: (CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
          onDateSelected?.call(details.date!);
        }
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final CSIEvent event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.eventName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${event.startTime.hour}:${event.startTime.minute} - ${event.endTime.hour}:${event.endTime.minute}',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '${event.startTime.day}/${event.startTime.month}/${event.startTime.year}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
