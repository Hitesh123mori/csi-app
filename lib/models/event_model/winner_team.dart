import 'package:csi_app/models/event_model/event_user.dart';

class WinnerTeam {
  WinnerTeam({
    required this.name,
    required this.members,
    required this.rank,
  });

  late String name;
  late List<EventUser> members;
  late int rank;

  WinnerTeam.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    members = (json['members'] as List<dynamic>?)
        ?.map((memberJson) => EventUser.fromJson(memberJson))
        .toList() ??
        [];
    rank = json['rank'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'members': members.map((member) => member.toJson()).toList(),
      'rank': rank,
    };
    return data;
  }
}
