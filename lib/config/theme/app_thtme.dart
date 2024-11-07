import 'package:flutter/material.dart';
import 'package:todo_app_c12_online_sun/core/utils/colors_manager.dart';

import '../../core/utils/app_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      useMaterial3: false,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.blue,
          onPrimary: ColorsManager.white),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ColorsManager.blue,
        //toolbarHeight: 157,
        titleTextStyle: AppLightStyles.appBarTextStyle,
      ),
      scaffoldBackgroundColor: ColorsManager.scaffoldBg,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorsManager.white,
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.blue,
        unselectedItemColor: ColorsManager.grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          iconSize: 33,
          shape: StadiumBorder(
              side: BorderSide(color: ColorsManager.white, width: 4))),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        )),
        backgroundColor: ColorsManager.white,
        elevation: 18,
      ));
}
