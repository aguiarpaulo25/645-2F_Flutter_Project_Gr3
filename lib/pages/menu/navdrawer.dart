import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/menu/aboutus.dart';
import 'package:flutter_project/pages/menu/settings.dart';
import 'package:provider/src/provider.dart';

import '../../auth/authentication_service.dart';
import 'contact.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  get changeDarkMode => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          ListTile(
              leading: Icon(Icons.account_circle,
                  color: Theme.of(context).primaryIconTheme.color),
              title: Text(FirebaseAuth.instance.currentUser!.email.toString())),
          const Divider(
            height: 32,
            thickness: 1,
            color: Color(0xFF666666),
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
              leading: Icon(Icons.home,
                  color: Theme.of(context).primaryIconTheme.color),
              title: const Text('Home').tr(),
              onTap: () => selectedItem(context, 0)),
          ListTile(
              leading: Icon(Icons.settings,
                  color: Theme.of(context).primaryIconTheme.color),
              title: const Text('Settings').tr(),
              onTap: () => selectedItem(context, 1)),
          ListTile(
              leading: Icon(Icons.info,
                  color: Theme.of(context).primaryIconTheme.color),
              title: const Text('AboutUs').tr(),
              onTap: () => selectedItem(context, 2)),
          ListTile(
              leading: Icon(Icons.email,
                  color: Theme.of(context).primaryIconTheme.color),
              title: const Text('Contact').tr(),
              onTap: () => selectedItem(context, 3)),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                  leading: Icon(Icons.logout,
                      color: Theme.of(context).primaryIconTheme.color),
                  title: const Text('LogOut').tr(),
                  onTap: () => selectedItem(context, 4)),
            ),
          )
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Settings()));
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AboutUs()));
        break;
      case 3:
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Contact()));
        break;
      case 4:
        context.read<AuthenticationService>().signOut();
        break;
    }
  }
}
