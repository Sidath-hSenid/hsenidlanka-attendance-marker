import 'dart:async';

import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../utils/constants/text_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Container(
        color: ColorConstants.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              TextConstants.appLogoImageLink,
              height: screenHeight / 2,
              width: screenWidth / 2,
              fit: BoxFit.contain,
            ),
          ],
        ));
  }
}
