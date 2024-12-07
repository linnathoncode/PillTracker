import 'package:flutter/material.dart';
import 'package:pill_tracker/core/configs/assets/app_images.dart';
import 'package:pill_tracker/core/configs/constants/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil(mainPageRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.3,
          heightFactor: 0.3,
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }
}
