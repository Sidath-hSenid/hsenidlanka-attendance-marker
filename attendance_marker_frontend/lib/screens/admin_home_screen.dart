import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_users_screen.dart';
import 'package:attendance_marker_frontend/utils/widgets/card_widget.dart';
import 'package:attendance_marker_frontend/utils/widgets/user_app_bar_widget.dart';
import 'package:flutter/material.dart';

import '../utils/constants/size_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/navigational_drawer_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
      drawer:
            NavigationalDrawerWidget.functionAdminNavigationalDrawer(context),
      appBar: UserAppBarWidget.functionAppBarInside(TextConstants.appTitle, context),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.all(SizeConstants.cardPaddingAll),
              child: GestureDetector(
                child: CardWidget.functionAdminHomeCardWidget(
                    screenHeight, screenWidth, TextConstants.companiesCardImageLink, TextConstants.adminCardCompanyTitle, TextConstants.adminCardCompanySubTitle, context),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageCompaniesScreen()));
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(SizeConstants.cardPaddingAll),
              child: GestureDetector(
                child: CardWidget.functionAdminHomeCardWidget(
                    screenHeight, screenWidth, TextConstants.usersCardImageLink, TextConstants.adminCardUserTitle, TextConstants.adminCardUserSubTitle, context),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageUsersScreen()));
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(SizeConstants.cardPaddingAll),
              child: GestureDetector(
                child: CardWidget.functionAdminHomeCardWidget(
                    screenHeight, screenWidth, TextConstants.attendacesCardImageLink, TextConstants.adminCardAttendancesTitle, TextConstants.adminCardAttendancesSubTitle, context),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageAttendancesScreen()));
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}