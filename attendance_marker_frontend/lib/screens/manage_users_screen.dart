import 'package:attendance_marker_frontend/screens/add_user_screen.dart';
import 'package:attendance_marker_frontend/screens/all_users_screen.dart';
import 'package:attendance_marker_frontend/screens/users_all_companies_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/icon_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';
import '../utils/constants/color_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/widgets/navigational_drawer_widget.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer:
            NavigationalDrawerWidget.functionAdminNavigationalDrawer(context),
        appBar: AppBar(
          title: const Text(TextConstants.manageUserAppBarTitleText),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(IconConstants.viewUsers),
                  text: TextConstants.allUsersAppBarTitleText),
              Tab(
                  icon: Icon(IconConstants.addUser),
                  text: TextConstants.addUserAppBarTitleText),
              Tab(
                  icon: Icon(IconConstants.viewCompanies),
                  text: TextConstants.usersByCompanyAppBarTitleText)
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
                UserService().logOut(context);
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            AllUsersScreen(),
            AddUserScreen(),
            UsersAllCompaniesScreen(),
          ],
        ),
      ),
    );
  }
}
