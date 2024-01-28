import 'package:csi_app/models/event_model/event_user.dart';
import 'package:csi_app/models/event_model/sponsor.dart';
import 'package:csi_app/models/event_model/winner_prices.dart';
import 'package:csi_app/models/event_model/winner_team.dart';

class Event {
  Event({
    required this.name,
    required this.type,
    required this.date,
    required this.description,
    this.totalParticipants,
    this.subEvents,
    this.volunteers,
    this.sponsors,
    this.chiefGuests,
    this.imageFolderPath,
    this.numberOfDays,
    this.winners,
    this.prices,
    required this.year,
    required this.id ,
  });

  late String name;
  late String date ;
  late String type;
  late String description;
  late double? totalParticipants;
  late List<Event>? subEvents;
  late List<EventUser>? volunteers;
  late List<EventSponser>? sponsors;
  late List<String>? chiefGuests;
  late String? imageFolderPath;
  late double? numberOfDays;
  late List<WinnerTeam>? winners;
  late List<WinnerPrice>? prices;
  late String year;
  late String id ;


  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    date = json['date'] ?? '' ;
    type = json['type'] ?? '';
    description = json['description'] ?? '';
    totalParticipants = json['totalParticipants'];
    subEvents = (json['subEvents'] as List<dynamic>?)
        ?.map((eventJson) => Event.fromJson(eventJson))
        .toList();
    volunteers = (json['volunteers'] as List<dynamic>?)
        ?.map((userJson) => EventUser.fromJson(userJson))
        .toList();
    sponsors = (json['sponsors'] as List<dynamic>?)
        ?.map((sponsorJson) => EventSponser.fromJson(sponsorJson))
        .toList();
    chiefGuests = (json['chiefGuests'] as List<dynamic>?)?.cast<String>();
    imageFolderPath = json['imageFolderPath'];
    numberOfDays = json['numberOfDays'] ?? 0.0;
    winners = (json['winners'] as List<dynamic>?)
        ?.map((winnerJson) => WinnerTeam.fromJson(winnerJson))
        .toList();
    prices = (json['prices'] as List<dynamic>?)
        ?.map((priceJson) => WinnerPrice.fromJson(priceJson))
        .toList();
    year = json['year'] ?? '';
    id = json['id'] ?? '' ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'date' :date,
      'type': type,
      'description': description,
      'totalParticipants': totalParticipants,
      'subEvents': subEvents?.map((event) => event.toJson()).toList(),
      'volunteers': volunteers?.map((user) => user.toJson()).toList(),
      'sponsors': sponsors?.map((sponsor) => sponsor.toJson()).toList(),
      'chiefGuests': chiefGuests,
      'imageFolderPath': imageFolderPath,
      'numberOfDays': numberOfDays,
      'winners': winners?.map((winner) => winner.toJson()).toList(),
      'prices': prices?.map((price) => price.toJson()).toList(),
      'year': year,
      'id' :id ,
    };
    return data;
  }

}

