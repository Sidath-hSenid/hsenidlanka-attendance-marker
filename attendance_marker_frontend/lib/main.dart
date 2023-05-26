import 'package:attendance_marker_frontend/screens/admin_home_screen.dart';
import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/splash_screen.dart';
import 'package:attendance_marker_frontend/screens/user_home_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TextConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorConstants.primaryColor,
      ),
      home: const LoginScreen(),
    );
  }
}
