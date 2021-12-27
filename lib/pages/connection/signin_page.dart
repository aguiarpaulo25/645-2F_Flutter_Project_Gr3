import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/connection/signup_page.dart';
import 'package:flutter_project/utils/theme_colors.dart';
import 'package:provider/src/provider.dart';

import '../../auth/authentication_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void showMessage(message) {
    if (message != 'Signed in') {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Login").tr(),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextField(
              obscureText: _obscureText,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: _toggle,
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: _obscureText
                            ? const Color(0xFF666666)
                            : Theme.of(context).primaryColor),
                  ))),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthenticationService>()
                  .signIn(emailController.text.trim(),
                      passwordController.text.trim())
                  .then((value) => showMessage(value));
            },
            child: const Text("Sign in"),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account ? "),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text('Register',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
