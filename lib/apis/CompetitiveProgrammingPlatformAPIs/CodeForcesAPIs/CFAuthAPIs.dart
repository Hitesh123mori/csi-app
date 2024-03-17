import 'dart:convert';
import 'dart:developer';

import 'package:csi_app/apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/CodeForcesURLs.dart';
import 'package:http/http.dart' as http;

import 'package:csi_app/models/ap_models/cf_models/contestants_model.dart';

class CFAuthAPIs {
  Future<List<Contestant>?> getContestStanding(int contestId) async {
    String uri = CodeForcesURLs.contestStanding(id: contestId);

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
