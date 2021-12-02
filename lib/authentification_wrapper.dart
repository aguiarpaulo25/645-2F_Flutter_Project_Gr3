import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/signin_page.dart';
import 'package:provider/src/provider.dart';

import 'homepage.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key, required this.changeDarkMode}) : super(key: key);

  final Function() changeDarkMode;

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    try {
      context.watch<User>();
      return const HomePage();
    } on ProviderNullException {
      return SignInPage(changeDarkMode: widget.changeDarkMode);
    }
  }
}