import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:random_string/random_string.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

class CFAuth {
  Map<String, dynamic> options;

  CFAuth({this.options = const {}});

  Future<String> genURL(String original) async {
    int attempts = 0;
    const maxAttempts = 10;
    const retryDelay = Duration(seconds: 1);

    while (attempts < maxAttempts) {
      String url = await _generateSignedURL(original);
      if (await _validateURL(url)) {
        return url;
      }
      attempts++;
      await Future.delayed(retryDelay);
    }

    throw Exception('Max attempts reached, unable to generate a valid URL.');
  }

  Future<String> _generateSignedURL(String original) async {
    int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String pref = randomString(6);
    Uri ori = Uri.parse(original);
    String? method = RegExp(r"api.(.*)").firstMatch(ori.path)?.group(1);
    Map<String, dynamic> query = Uri.splitQueryString(ori.query);
    List<List<String>> params = [
      ['apiKey', options['key']],
      ['time', '$time']
    ];
    query.forEach((key, value) {
      params.add([key, value]);
    });
    params.sort((x, y) {
      if (x[0] == y[0]) return x[1].compareTo(y[1]);
      return x[0].compareTo(y[0]);
    });
    String queryString = params.map((param) => '${param[0]}=${param[1]}').join('&');
    String toHash = '$pref/$method?$queryString#${options['secret']}';
    String hash = sha512.convert(utf8.encode(toHash)).toString();
    return '$original&apiKey=${options['key']}&time=$time&apiSig=$pref$hash';
  }

  Future<bool> _validateURL(String url) async {
    http.Response res = await http.get(Uri.parse(url));
    final resJson = json.decode(res.body);
    bool isNotValid = resJson["status"] == "FAILED" && resJson["comment"] == "apiKey: Incorrect signature";
    print("#valid: ${!isNotValid}");
    return !isNotValid; // Check if URL contains 'valid'
  }
}
