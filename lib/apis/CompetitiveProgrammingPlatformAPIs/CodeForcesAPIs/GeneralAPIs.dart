import 'dart:convert';
import 'package:csi_app/apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/CodeForcesURLs.dart';
import 'package:csi_app/models/user_model/CodeforcesUserProfile.dart';
import 'package:http/http.dart' as http;

class GeneralAPIs{
  static Future<dynamic> getCFSubmissions(String handle) async {
    final response = await http.get(Uri.parse(CodeForcesURLs.userProblemSolved(username: handle)));

    if (response.statusCode != 200) {
      return {"error": 'Failed to load data: ${response.statusCode}'};
      // throw Exception('Failed to load data: ${response.statusCode}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> submissions = responseData['result'];
    final List<dynamic> acSubmissions = submissions.where((submission) => submission['verdict'] == 'OK').toList();

    final Map<int, List<Map<String, dynamic>>> resMap = {};
    final Set<String> done = {};

    for (final submission in acSubmissions) {
      print("p : ${submission['problem']}");
      if(submission['problem']['rating'] == null) continue;
      final problemRating = submission['problem']['rating'] as int;
      final problemName = submission['problem']['name'] as String;

      if (!done.contains(problemName)) {
        done.add(problemName);

        if (!resMap.containsKey(problemRating)) {
          resMap[problemRating] = [];
        }

        resMap[problemRating]!.add({
          'problemName': problemName,
          'problemUrl': 'https://codeforces.com/problemset/problem/${submission['problem']['contestId']}/${submission['problem']['index']}',
          'submissionUrl': 'https://codeforces.com/contest/${submission['problem']['contestId']}/submission/${submission['id']}',
          'platform': 'codeforces',
          'timestamp': submission['creationTimeSeconds'],
          'rating': problemRating,
        });
      }
    }

    // Count number of problems solved in each rating category
    final Map<int, int> ratingCountMap = {};
    int count = 0;
    for (final rating in resMap.keys) {
      ratingCountMap[rating] = resMap[rating]!.length;
      count+= resMap[rating]!.length;
    }

    print("#c : ${count}");
    return {'problems': resMap, 'ratingCount': ratingCountMap, "totalCount": count};
  }


  static Future<CodeforcesUserProfile?> fetchCodeforcesUserProfile(String handle) async {
    final response = await http.get(Uri.parse('https://codeforces.com/api/user.info?handles=$handle'));

    if (response.statusCode != 200) {
      print('Failed to load data: ${response.statusCode}');
      return null;
      // throw Exception('Failed to load data: ${response.statusCode}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> users = responseData['result'];

    if (users.isEmpty) {
      throw Exception('User not found');
    }

    return CodeforcesUserProfile.fromJson(users[0]);
  }

}