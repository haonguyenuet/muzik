import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muzik/config/app_routes.dart';
import 'package:muzik/config/app_theme.dart';
import 'package:muzik/controllers/player_controller.dart';
import 'package:muzik/core/constants/constants.dart';
import 'package:muzik/core/utils/utility.dart';
import 'package:muzik/controllers/song_controller.dart';
import 'package:muzik/presentations/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    AppHelper.platform = Theme.of(context).platform;
    return ScreenUtilInit(
      designSize: const Size(
        DimensionConstants.screenWidth,
        DimensionConstants.screenHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Material(
        color: Colors.transparent,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsConstant.appName,
          theme: AppTheme.currentTheme,
          getPages: AppPages.pages,
          initialBinding: InitialBinding(),
          home: const HomePage(),
          defaultTransition: Transition.rightToLeft,
        ),
      ),
    );
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongController>(() => SongController());
    Get.lazyPut<PlayerController>(() => PlayerController());
  }
}
