import 'package:flutter/material.dart';
import 'package:flutter_project/theme_service.dart';
import 'package:provider/src/provider.dart';

import 'authentication_service.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dark mode"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                  emailController.text.trim(), passwordController.text.trim());
            },
            child: const Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                  emailController.text.trim(), passwordController.text.trim());
            },
            child: const Text("Sign up"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ThemeService>().toggleMode();
            },
            child: const Text("Dark Mode"),
          )
        ],
      ),
    );
  }
}
