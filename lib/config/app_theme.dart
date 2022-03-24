import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzik/config/app_color.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
    brightness: Brightness.dark,
    dividerColor: Colors.white30,
    scaffoldBackgroundColor: AppColor.primaryBgr,
    backgroundColor: AppColor.primaryBgr,
    appBarTheme: const AppBarTheme(backgroundColor: AppColor.primaryBgr),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.primaryBgr.withOpacity(.8),
      elevation: 0,
    ),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 2,
      color: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.white70,
      inactiveTrackColor: Colors.white30,
      thumbColor: Colors.white,
      trackHeight: 3,
      overlayColor: Colors.white30,
      trackShape: FullWidthSliderTrackShape(),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 30.h,
      ),
      headline2: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 28.h,
      ),
      headline3: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.h,
      ),
      headline4: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.h,
      ),
      headline5: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 20.h,
      ),
      headline6: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 18.h,
      ),
      bodyText1: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 24.h,
      ),
      bodyText2: TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 22.h,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}

class FullWidthSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    @required RenderBox? parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme?.trackHeight ?? 3;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox!.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
