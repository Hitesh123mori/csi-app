class Poll {
  final String fromid;
  final String id;
  final String question;
  final String end_date;
  final List<Options> options;

  Poll({
    required this.fromid,
    required this.id,
    required this.question,
    required this.end_date,
    required this.options,
  });
  Poll.fromJson(Map<String, dynamic> json)
      : fromid = json['fromid'] ?? '',
        id = json['id'] ?? '',
        question = json['question'] ?? '',
        end_date = json['end_date'] ?? '',
        options = List<Options>.from(json['options'] ?? []);

  // Serialization method
  Map<String, dynamic> toJson() {
    return {
      'fromid': fromid,
      'id': id,
      'question': question,
      'end_date': end_date,
      'options': options,
    };
  }
}



class Options {
  final String id;
  final String title;
  final int votes;

  Options({
    required this.id,
    required this.title,
    required this.votes,
  });
}




