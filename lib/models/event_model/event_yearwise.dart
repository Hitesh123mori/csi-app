import 'event.dart';

class EventYear {
  late String year;
  late List<Event> events;

  EventYear({
    required this.year,
    required this.events,
  });

  EventYear.fromJson(Map<String, dynamic> json) {
    year = json['year'] ?? "" ;
    events = (json['events'] as List<dynamic>?)
        ?.map((eventJson) => Event.fromJson(eventJson))
        .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'year': year,
      'events': events.map((event) => event.toJson()).toList(),
    };
    return data;
  }
}
