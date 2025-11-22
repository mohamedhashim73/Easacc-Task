import 'dart:io';

import 'package:easacc_task/core/constants/extensions/int_extensions.dart';
import 'package:easacc_task/core/services/user_session_service.dart';
import 'package:easacc_task/views/auth_page/login_page.dart';
import 'package:easacc_task/views/settings_page/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import '../network/cache_network.dart';
import '../services/dependency_injection.dart';
import '../theme/app_colors.dart';

class AppConstants {
  static const String kMainFont = "Cairo";
  static Future<void> kAppInitialization() async {
    Future.value([
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      await CacheManager.cacheInitialization(),
      DI.init(),
    ]);
  }
  static bool kPlatformIsIOS = Platform.isMacOS || Platform.isIOS;
  static Widget Function(BuildContext, int) kSeparatorBuilder() => (context, index) => 10.vrSpace;
  static BorderRadius kMainRadius = BorderRadius.circular(10);
  static BorderRadius kMaxRadius = BorderRadius.circular(22);
  static BoxBorder kMainBorder = Border.all(color: const Color(0xffF1F5F7));
  static InputBorder kEnabledInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: Colors.black.withOpacity(0),width: 0.71));
  static InputBorder kFocusedInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: AppColors.kMain,width: 0.71));
  static InputBorder kErrorInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: AppColors.kRed,width: 0.71));
  static BoxBorder kSkeletonLoadingBorder = Border.all(color: const Color(0xff2684FF).withOpacity(0.04));
  static Widget get kGetMainRoute => UserSessionService.isLoggedIn ? SettingsPage() : LoginPage();
}
