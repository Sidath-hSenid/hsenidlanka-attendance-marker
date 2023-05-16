import 'package:attendance_marker_frontend/screens/add_company_screen.dart';
import 'package:attendance_marker_frontend/screens/forgot_password_screen.dart';
import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/screens/reset_password_screen.dart';
import 'package:attendance_marker_frontend/screens/validate_otp_screen.dart';
import 'package:attendance_marker_frontend/utils/variables/color_palette.dart';
import 'package:attendance_marker_frontend/utils/variables/text_values.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextValues.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorPalette.primaryColor,
      ),
      home: const AddCompanyScreen(),
    );
  }
}
