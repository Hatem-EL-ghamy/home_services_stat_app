import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/theming/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Always navigate to Select Language after Splash
    Navigator.of(context).pushReplacementNamed(Routes.selectLanguageScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or App Icon
            Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: ColorsApp.mainGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.home,
                size: 80,
                color: ColorsApp.white,
              ),
            ),
            SizedBox(height: 30.h),
            // App Name
            Text(
              'HomeEase',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: ColorsApp.mainGreen,
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(height: 10.h),
            // Loading indicator
            SizedBox(
              width: 30.w,
              height: 30.h,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(ColorsApp.mainGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

