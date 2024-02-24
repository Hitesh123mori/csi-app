import 'package:url_launcher/url_launcher.dart';

class Functions{


  static void launchURL(String url) {
    launchUrl(Uri.parse(url));
  }


}