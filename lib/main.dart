import 'package:flutter/material.dart';
import 'package:pill_tracker/core/configs/constants/routes.dart';
import 'package:pill_tracker/core/configs/theme/app_themes.dart';
import 'package:pill_tracker/features/notification/data/datasources/local_notification.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/main_page/main_page.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/pill_info_page/pill_info_page.dart';
import 'package:pill_tracker/features/pill_crud/presentation/pages/splash_page/splash_page.dart';
import 'package:pill_tracker/features/pill_crud/presentation/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PillProvider(),
        )
      ],
      child: MaterialApp(
        routes: {
          mainPageRoute: (context) => const MainPage(),
          pillInfoPageRoute: (context) => const PillInfoPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        home: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
