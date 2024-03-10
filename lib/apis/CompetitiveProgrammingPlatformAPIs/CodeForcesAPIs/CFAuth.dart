import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:random_string/random_string.dart';


/// to Add signature
class CFAuth {
  Map<String, dynamic> options;

  CFAuth({this.options = const {}});

  String genURL(String original) {
    String ans = original;
    int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String pref = randomString(6);
    Uri ori = Uri.parse(original);
    Map<String, dynamic> query = Uri.splitQueryString(ori.query);
    String? method = RegExp(r"api.(.*)").firstMatch(ori.path)?.group(1);
    List<List<String>> params = [
      ['apiKey', this.options['key']],
      ['time', '$time']
    ];
    query.forEach((key, value) {
      params.add([key, value]);
    });
    params.sort((x, y) {
      if (x[0] == y[0]) return x[1].compareTo(y[1]);
      return x[0].compareTo(y[0]);
    });
    String toHash = '$pref/$method?';
    for (int i = 0; i < params.length; ++i) {
      if (i > 0) toHash += '&';
      toHash += '${params[i][0]}=${params[i][1]}';
    }
    toHash += '#${this.options['secret']}';
    var bytes = utf8.encode(toHash);
    var hash = sha512.convert(bytes).toString();
    ans = original;
    if (query.isNotEmpty) {
      ans += '&';
    }
    ans += 'apiKey=${this.options['key']}&time=$time&apiSig=$pref';
    return ans + hash;
  }
}
