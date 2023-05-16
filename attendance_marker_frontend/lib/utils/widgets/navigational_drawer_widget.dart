import 'package:flutter/material.dart';

import '../variables/text_values.dart';

class NavigationalDrawerWidget {
  static functionUserNavigationalDrawer(BuildContext context) {
    var paddings = const EdgeInsets.symmetric(horizontal: 16);

    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Material(
        color: Colors.teal,
        child: ListView(
          padding: paddings,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: size.height / 5,
                width: size.width,
                child: Image.asset(TextValues.appLogoImageLink),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              text: 'Categories',
              icon: Icons.category,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              text: 'Questions',
              icon: Icons.question_answer,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              text: 'Users',
              icon: Icons.account_circle,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              text: 'Problems',
              icon: Icons.report_problem,
              onClicked: () => selectedItem(context, 4),
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
    const color = Colors.white;
    const hoverColor = Colors.white;
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

  static void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => MainMenu(),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => CategoryList(),
        // ));
        break;
      case 2:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => QuestionsList(),
        // ));
        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => UserList(),
        // ));
        break;
      case 4:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ProblemMenu(),
        // ));
        break;
      case 5:
        // UserService().signout();
        break;
    }
  }
}
