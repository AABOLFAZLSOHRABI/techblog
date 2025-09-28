import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../gen/assets.gen.dart';
import '../constant/my_colors.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(NamedRoute.routeMainScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.images.logo.path, height: 64),
              const SizedBox(height: 32),
              const SpinKitFadingCube(
                color: SolidColors.primaryColor,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
