import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nawel/presentation/resources/assets_manager.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/constants_manager.dart';
import 'package:nawel/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(
      const Duration(seconds: AppConstants.timerDuration),
      _goNext,
    );
  }

  Future<void> _goNext() async {
    final box = Hive.box('settings');

    final bool isOnBoarded = box.get('onBoarded', defaultValue: false);
    final bool isLoggedIn = box.get('loggedIn', defaultValue: false);

    if (!isOnBoarded) {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    } else if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Center(child: Image(image: AssetImage(ImageAssets.appLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
