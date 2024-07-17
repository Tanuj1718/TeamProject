import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(
      children : [
        Center(
          child: LottieBuilder.asset("assets/Lottie/Animation - 1720324708094.json"),
        )
      ]
    ), nextScreen: const Wrapper(),
    splashIconSize: 400,
    backgroundColor: Colors.white,
    );
  }
}
