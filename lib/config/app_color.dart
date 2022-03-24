import 'package:flutter/material.dart';

class AppColor {
  static const Map<int, Color> grey = <int, Color>{
    800: Color(0xFF303030),
    900: Color(0xFF252525)
  };

  static const black = Color.fromARGB(255, 0, 0, 0);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF0191F7);
  static const maroon = Color(0xFFBF2043);
  static const green = Color(0xFF56A052);
  static const red = Color(0xFFC34848);
  static const orange = Color(0xFFFF7D2E);

  static const primaryText = Color.fromRGBO(255, 255, 255, .9);
  static const primaryBgr = AppColor.black;
  static const highlight = AppColor.orange;

  static const shimmerBaseColor = Color.fromARGB(255, 233, 232, 232);
  static const shimmerHighlightColor = Color(0xFFEEEEEE);
  static const gradientStartColor = Color(0xff2f2a50);
  static const gradientEndColor = Color(0xff454073);
  static const shadowColor = Color(0x190a1f44);
  static const cardShadowColor = Color(0xFFd3d1d1);
  static const headerTextColor = Color(0xFFe5e5e5);
  static const dividerColor = Color(0xFF575c69);
  static const borderColor = Color.fromARGB(255, 218, 214, 214);
  static const splashColor = Color.fromARGB(255, 236, 230, 230);
  static const highlightColor = Color(0xffcf534a);
  static const facebookColor = Color(0xFF3f5aa8);
  static const googleColor = highlightColor;

  ///Singleton factory
  static final AppColor _instance = AppColor._internal();

  factory AppColor() {
    return _instance;
  }

  AppColor._internal();
}
