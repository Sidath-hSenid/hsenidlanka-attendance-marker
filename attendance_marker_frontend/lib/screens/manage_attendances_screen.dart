import 'package:attendance_marker_frontend/screens/all_attendances_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/icon_constants.dart';
import '../utils/constants/text_constants.dart';
import '../utils/widgets/navigational_drawer_widget.dart';
import 'attendances_all_users_screen.dart';

class ManageAttendancesScreen extends StatefulWidget {
  const ManageAttendancesScreen({super.key});

  @override
  State<ManageAttendancesScreen> createState() =>
      _ManageAttendancesScreenState();
}

class _ManageAttendancesScreenState extends State<ManageAttendancesScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer:
            NavigationalDrawerWidget.functionAdminNavigationalDrawer(context),
        appBar: AppBar(
          title: const Text(TextConstants.manageAttendancesAppBarTitleText),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(IconConstants.viewAttendances),
                  text: TextConstants.allAttendancesAppBarTitleText),
              Tab(
                  icon: Icon(IconConstants.viewUsers),
                  text: TextConstants.attendanceSByUserAppBarTitleText),
            ],
          ),
          actions: <Widget>[
            IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                IconConstants.appLogOut,
                color: ColorConstants.appBarIconColor,
                size: SizeConstants.appBarIconSize,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            AllAttendancesScreen(),
            AttendancesAllUsersScreen()
          ],
        ),
      ),
    );
  }
}
