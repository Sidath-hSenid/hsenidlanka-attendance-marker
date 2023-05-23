import 'package:attendance_marker_frontend/screens/add_company_screen.dart';
import 'package:attendance_marker_frontend/screens/all_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/users_by_company_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/icon_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';

import '../utils/constants/color_constants.dart';
import '../utils/constants/size_constants.dart';
import '../utils/widgets/navigational_drawer_widget.dart';

class ManageCompaniesScreen extends StatefulWidget {
  const ManageCompaniesScreen({super.key});

  @override
  State<ManageCompaniesScreen> createState() => _ManageCompaniesScreenState();
}

class _ManageCompaniesScreenState extends State<ManageCompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer:
            NavigationalDrawerWidget.functionAdminNavigationalDrawer(context),
        appBar: AppBar(
          title: const Text(TextConstants.manageCompanyAppBarTitleText),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(IconConstants.viewCompanies),
                  text: TextConstants.allCompaniesAppBarTitleText),
              Tab(
                  icon: Icon(IconConstants.addCompany),
                  text: TextConstants.addCompanyAppBarTitleText),
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
            AllCompaniesScreen(),
            AddCompanyScreen()
          ],
        ),
      ),
    );
  }
}
