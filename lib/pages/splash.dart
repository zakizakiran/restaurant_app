import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: SvgPicture.asset('assets/img/logo.svg'),
      nextScreen: const RestaurantListPage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
