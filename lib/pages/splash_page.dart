import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/navigation/bottom_navigation.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: SvgPicture.asset('assets/img/logo.svg'),
      nextScreen: const BottomNavigation(initialIndex: 0),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
