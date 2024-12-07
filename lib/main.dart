import 'package:flutter/material.dart';
import 'package:pill_tracker/core/configs/constants/routes.dart';
import 'package:pill_tracker/core/configs/theme/app_themes.dart';
import 'package:pill_tracker/presentation/main_page/pages/main_page.dart';
import 'package:pill_tracker/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        splashRoute: (context) => const SplashPage(),
        mainPageRoute: (context) => const MainPage(),
      },
      home: const SplashPage(),
    );
  }
}
