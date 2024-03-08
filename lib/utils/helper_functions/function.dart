import 'dart:convert';

import 'package:csi_app/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperFunctions{


  static void launchURL(String url) {
    launchUrl(Uri.parse(url));
  }


  /// for show more text
  static String truncateDescription(String content) {
    return content.length > 100 ? content.substring(0, 100) + '... ' : content;
  }


  /// for detecting hyper links
  static Widget buildContent(String content) {
    List<InlineSpan> children = [];

    RegExp regex = RegExp(r'https?://\S+');
    Iterable<RegExpMatch> matches = regex.allMatches(content);

    int currentIndex = 0;

    for (RegExpMatch match in matches) {
      String url = match.group(0)!;
      int start = match.start;
      int end = match.end;

      children.add(TextSpan(text: content.substring(currentIndex, start)));

      children.add(
        TextSpan(
          text: url,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              HelperFunctions.launchURL(url);
            },
        ),
      );

      currentIndex = end;
    }

    children.add(TextSpan(text: content.substring(currentIndex)));

    return RichText(
        text: TextSpan(
          children: children,
          style: TextStyle(color: AppColors.theme['tertiaryColor'], fontSize: 15),
        ));
  }


  //for encodeing
  static String stringToBase64(String text){
    return base64.encode(utf8.encode(text));
  }
  static String base64ToString(String encodeText){
    return utf8.decode(base64.decode(encodeText));
  }

}

main (){
  print("#e ${HelperFunctions.stringToBase64("https://drive.usercontent.google.com/u/0/uc?id=1UDvG0vMZUncEBU820ubJxr8mOmfvCNjU&export=download")}");
}