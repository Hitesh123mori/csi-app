import 'CFAuth.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

import 'dart:developer';

class CodeForcesURLs{

  static final CFAuth _cfAuth = CFAuth(options: {"key": key,"secret": secret});


  static String userProfile({required String username}){
    return "https://codeforces.com/api/user.info?handles=${username.toString()}";
  }

  static String userProblemSolved({required String username}){
    return 'https://codeforces.com/api/user.status?handle=$username&from=1&count=100000';
  }

  static String contestStanding({required int id, bool asManger=true, int from=1, int count=20, bool showUnofficial=false}){
    return _cfAuth.genURL("https://codeforces.com/api/contest.standings?contestId=${id.toString()}&asManager=${asManger.toString()}&from=${from.toString()}&count=${count.toString()}&showUnofficial=${showUnofficial.toString()}");
  }


}

void main () async {
  String uri = CodeForcesURLs.contestStanding(id: 499642);
  // String uri = CodeForcesURLs.getContestList();

  http.Response res = await http.get(Uri.parse(uri));
  
  log("res-status: ${res.statusCode}");
  log("res: ${res.body}");

  
}