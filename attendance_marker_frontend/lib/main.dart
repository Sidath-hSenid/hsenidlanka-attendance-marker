import 'package:attendance_marker_frontend/screens/add_end_time_screen.dart';
import 'package:attendance_marker_frontend/screens/add_start_time_screen.dart';
import 'package:attendance_marker_frontend/screens/add_user_screen.dart';
import 'package:attendance_marker_frontend/screens/all_users_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_users_screen.dart';
import 'package:attendance_marker_frontend/screens/user_home_screen.dart';
import 'package:attendance_marker_frontend/screens/user_view_attendances_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
      home: const UserHomeScreen(),
    );
  }
}
