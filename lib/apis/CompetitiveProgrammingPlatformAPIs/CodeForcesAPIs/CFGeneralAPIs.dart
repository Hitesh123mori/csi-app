import 'dart:convert';
import 'dart:developer';
import 'package:csi_app/apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/CodeForcesURLs.dart';
import 'package:http/http.dart' as http;

import '../../../models/ap_models/cf_models/contestants_model.dart';

class CFGeneralAPIs{


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
      log("p : ${submission['problem']}");
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

    log("#c : ${count}");
    return {'problems': resMap, 'ratingCount': ratingCountMap, "totalCount": count};
  }


  static Stream<Map<String, dynamic>> fetchCodeforcesUserProfile(String handle) async* {
    final response = await http.get(Uri.parse('https://codeforces.com/api/user.info?handles=$handle'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final List<dynamic> users = responseData['result'];

      if (users.isNotEmpty) {
        yield {
          'handle': users[0]['handle'],
          'rating': users[0]['rating'] ?? '0',
          'rank': users[0]['rank'] ?? "None",
          'maxRating': users[0]['maxRating'] ?? '0',
          'maxRank': users[0]['maxRank'] ?? 'None',
        };
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }


  static Future<List<Contestant>?> getContestStanding(int contestId) async {
    String uri = await CodeForcesURLs.contestStanding(id: contestId);

    http.Response res = await http.get(Uri.parse(uri));
    log("res-status: ${res.statusCode}");
    log("res: ${res.body}");

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List<dynamic> rows = data['result']['rows'];

      return List.generate(
        rows.length,
            (index) => Contestant.fromJson(rows[index]),
      );
    } else {
      log("#Error-cf: ${res.statusCode}");
      return null;
    }

    return null;
  }
}