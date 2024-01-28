class EventUser {
  EventUser({
    required this.name,
    this.rollNum,
     this.id,
  });

  late String name;
  late String? rollNum;
  late String? id ;


  EventUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    rollNum = json['rollNum'];
    id = json['id'] ?? '' ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'rollNum': rollNum,
      'id' : id,
    };
    return data;
  }
}
