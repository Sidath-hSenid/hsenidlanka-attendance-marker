import 'package:attendance_marker_frontend/screens/admin_home_screen.dart';
import 'package:attendance_marker_frontend/screens/login_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_attendances_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_companies_screen.dart';
import 'package:attendance_marker_frontend/screens/manage_users_screen.dart';
import 'package:attendance_marker_frontend/utils/constants/color_constants.dart';
import 'package:attendance_marker_frontend/utils/constants/icon_constants.dart';
import 'package:flutter/material.dart';
import '../constants/size_constants.dart';
import '../constants/text_constants.dart';

class NavigationalDrawerWidget {

  static functionUserNavigationalDrawer(username,email, companyName, companyLocation, context) {

    
    Size size = MediaQuery.of(context).size;
    var drawerHeight = size.height;
    var drawerWidth = size.width;

    return Drawer(
      child: Material(
        color: ColorConstants.drawerBodyColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeConstants.drawerPaddingHorizontal),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SizeConstants.drawerPaddingVertical),
              child: SizedBox(
                height: drawerHeight / SizeConstants.drawerImageHeightDivideBy,
                width: drawerWidth,
                child: Image.asset(TextConstants.appLogoImageLink),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: SizeConstants.titleTextPaddingHorizontal,
                  right: SizeConstants.titleTextPaddingHorizontal,
                  bottom: SizeConstants.titleTextPaddingBottom),
              child: Text(
                TextConstants.appTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConstants.drawerAppNameFontSize,
                    color: ColorConstants.drawerTextColor),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: username,
              icon: IconConstants.username,
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: email,
              icon: IconConstants.email,
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: companyName,
              icon: IconConstants.companyName,
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: companyLocation,
              icon: IconConstants.companyLocation,
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerSignOut,
              icon: IconConstants.appLogOut,
              onClicked: () => userSelectedItem(context, 0),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
          ],
        ),
      ),
    );
  }

  static functionAdminNavigationalDrawer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var drawerHeight = size.height;
    var drawerWidth = size.width;

    return Drawer(
      child: Material(
        color: ColorConstants.drawerBodyColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeConstants.drawerPaddingHorizontal),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SizeConstants.drawerPaddingVertical),
              child: SizedBox(
                height: drawerHeight / SizeConstants.drawerImageHeightDivideBy,
                width: drawerWidth,
                child: Image.asset(TextConstants.appLogoImageLink),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: SizeConstants.titleTextPaddingHorizontal,
                  right: SizeConstants.titleTextPaddingHorizontal,
                  bottom: SizeConstants.titleTextPaddingBottom),
              child: Text(
                TextConstants.appTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConstants.drawerAppNameFontSize,
                    color: ColorConstants.drawerTextColor),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerHome,
              icon: IconConstants.home,
              onClicked: () => adminSelectedItem(context, 0),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerCompanies,
              icon: IconConstants.companyName,
              onClicked: () => adminSelectedItem(context, 1),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerUsers,
              icon: IconConstants.users,
              onClicked: () => adminSelectedItem(context, 2),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerAttendances,
              icon: IconConstants.attendances,
              onClicked: () => adminSelectedItem(context, 3),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
            buildMenuItem(
              text: TextConstants.drawerSignOut,
              icon: IconConstants.appLogOut,
              onClicked: () => adminSelectedItem(context, 4),
            ),
            const Divider(
              color: ColorConstants.drawerIconColor,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = ColorConstants.drawerIconColor;
    const hoverColor = ColorConstants.drawerIconColor;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  static void userSelectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        // UserService().signout();
        break;
    }
  }

  static void adminSelectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageCompaniesScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ManageUsersScreen()));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ManageAttendancesScreen()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
    }
  }
}
