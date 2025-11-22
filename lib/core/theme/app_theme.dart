import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'app_colors.dart';

class AppTheme{
  static ThemeData kLight = ThemeData(
      fontFamily: AppConstants.kMainFont,
      scaffoldBackgroundColor: AppColors.kScaffoldBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.kWhite,
        type: BottomNavigationBarType.fixed,
        elevation: 0
      ),
      textTheme: TextTheme(
        labelMedium: TextStyle(fontSize: 14,fontWeight:FontWeight.w500,color : AppColors.kWhite)
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: AppColors.kWhite,
        backgroundColor: AppColors.kMain,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(color: AppColors.kWhite,fontFamily: AppConstants.kMainFont, fontSize: 16,fontWeight: FontWeight.w600)
      )
  );
}