import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'authentication_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.changeDarkMode}) : super(key: key);
  final Function() changeDarkMode;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              widget.changeDarkMode();
            },
            child: const Text("Dark Mode"),
          )
        ],
      ),
    );
  }
}
