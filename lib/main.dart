import 'package:easacc_task/core/constants/constants.dart';
import 'package:easacc_task/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'core/constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.kAppInitialization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: MaterialApp(
        theme: AppTheme.kLight,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRoutes.key,
        home: AppConstants.kGetMainRoute,
      ),
    );
  }
}