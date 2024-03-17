import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:random_string/random_string.dart';

class CFAuth {
  Map<String, dynamic> options;

  CFAuth({this.options = const {}});

  String genURL(String original) {
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
}
