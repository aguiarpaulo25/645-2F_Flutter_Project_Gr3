import 'package:flutter/material.dart';
import 'package:flutter_project/aboutus.dart';
import 'package:flutter_project/settings.dart';
import 'package:provider/src/provider.dart';

import 'authentication_service.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  get changeDarkMode => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          const ListTile(
            leading: Icon(Icons.account_circle, color: Color(0xFF666666)),
            title: Text(
              "test@test.ch",
            ),
          ),
          const Divider(
            height: 32,
            thickness: 1,
            color: Color(0xFF666666),
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF666666)),
            title: const Text('Home'),
            onTap: () => selectedItem(context, 0)
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF666666)),
            title: const Text('Settings'),
            onTap: () => selectedItem(context, 1)
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF666666)),
            title: const Text('About us'),
            onTap: () => selectedItem(context, 2)
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                  leading: const Icon(Icons.logout, color: Color(0xFF666666)),
                  title: const Text('Log out'),
                  onTap: () => selectedItem(context, 3)
              ),
            ),
          )
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch(index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Settings()));
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AboutUs()));
        break;
      case 3:
        context.read<AuthenticationService>().signOut();
        break;
    }
  }
}
