import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class CodeforcesApi {
  static const String baseUrl = 'https://codeforces.com/api/';
  String apiKey;
  String apiSecret;

  CodeforcesApi(this.apiKey, this.apiSecret);

  Future<Map<String, dynamic>> makeAuthenticatedRequest(
      String endpoint, Map<String, dynamic> queryParams) async {
    // Add apiKey to queryParams
    queryParams['apiKey'] = apiKey;

    // Add current time in unix format to queryParams
    queryParams['time'] = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Generate apiSig
    String rand = "454589"; // Choose arbitrary rand
    String queryString = _sortQueryParams(queryParams);
    String toHash = '$rand/$endpoint?$queryString#${apiSecret}';
    String hash = sha512.convert(utf8.encode(toHash)).toString();
    String apiSig = rand + hash.substring(0, 6);

    // Add apiSig to queryParams
    queryParams['apiSig'] = apiSig;

    // Construct URL with queryParams
    String url = baseUrl + endpoint;
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: queryParams);

    // Make request
    http.Response response = await http.get(uri);

    // Parse and return response
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("#res: ${response.body}");
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  String _sortQueryParams(Map<String, dynamic> queryParams) {
    List<String> keys = queryParams.keys.toList()..sort();
    List<String> params = [];
    for (String key in keys) {
      params.add('$key=${queryParams[key]}');
    }
    return params.join('&');
  }
}

void main() async {
  // Replace with your API key and secret
  String apiKey = 'YOUR_API_KEY';
  String apiSecret = 'YOUR_API_SECRET';

  CodeforcesApi codeforcesApi = CodeforcesApi(key, secret);

  // Example: Fetch user info for handle 'tourist'
  Map<String, dynamic> userInfo = await codeforcesApi.makeAuthenticatedRequest(
      'user.info', {'handles': 'tourist'});

  print(userInfo);
}
