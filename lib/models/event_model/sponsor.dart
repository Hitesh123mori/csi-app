class EventSponser {
  EventSponser({
    required this.name,
    required this.logoPath,
  });

  late String name;
  late String logoPath;


  EventSponser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    logoPath = json['logoPath'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'logoPath': logoPath,
    };
    return data;
  }
}
