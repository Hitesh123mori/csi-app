class Contestant {
  String handle;
  int rank;
  double points;
  int penalty;
  int successfulHackCount;
  int unsuccessfulHackCount;
  List<ProblemResult> problemResults;

  Contestant({
    required this.handle,
    required this.rank,
    required this.points,
    required this.penalty,
    required this.successfulHackCount,
    required this.unsuccessfulHackCount,
    required this.problemResults,
  });

  factory Contestant.fromJson(Map<String, dynamic> json) {
    return Contestant(
      handle: json['party']['members'][0]['handle'],
      rank: json['rank'],
      points: json['points'].toDouble(),
      penalty: json['penalty'],
      successfulHackCount: json['successfulHackCount'],
      unsuccessfulHackCount: json['unsuccessfulHackCount'],
      problemResults: (json['problemResults'] as List)
          .map((result) => ProblemResult.fromJson(result))
          .toList(),
    );
  }
  @override
  String toString() {
    return 'Handle: $handle, Rank: $rank';
  }
}

class ProblemResult {
  final double points;
  final int rejectedAttemptCount;
  final String type;
  final int bestSubmissionTimeSeconds;

  ProblemResult({
    required this.points,
    required this.rejectedAttemptCount,
    required this.type,
    required this.bestSubmissionTimeSeconds,
  });

  factory ProblemResult.fromJson(Map<String, dynamic> json) {
    return ProblemResult(
      points: json['points'].toDouble() ?? 0,
      rejectedAttemptCount: json['rejectedAttemptCount'] ?? 0,
      type: json['type'] ?? "",
      bestSubmissionTimeSeconds: json['bestSubmissionTimeSeconds'] ?? 0,
    );
  }


}

// List<Contestant> parseContestants(String jsonStr) {
//   final Map<String, dynamic> data = json.decode(jsonStr);
//   final List<dynamic> rows = data['result']['rows'];
//
//   return List.generate(
//     rows.length,
//         (index) => Contestant.fromJson(rows[index]),
//   );
// }
