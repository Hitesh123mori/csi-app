import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class AppColors {
  static Map theme = themes["theme1"];

  static Map themes = {
    "theme1": {
      "primaryColor":hexStringToColors("#061D4B"),
      "secondaryColor" :hexStringToColors("#FFFFFF"),
      "tertiaryColor": hexStringToColors("#000012"),
      "secondaryBgColor":hexStringToColors("#F3F8FF"),
      "borderColor" :hexStringToColors("#EFEFEF"),
      "backgroundColor":hexStringToColors("#F5F5F5")
    },

  };


}