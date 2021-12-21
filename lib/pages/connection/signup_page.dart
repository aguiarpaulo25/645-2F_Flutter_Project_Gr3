import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../auth/authentication_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void showMessage(message) {
    if (message != 'Registered') {
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
    } else {
      Navigator.pop(context);
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
        title: const Text("Create an account"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
                labelText: "Email", prefixIcon: Icon(Icons.email)),
          ),
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(
                labelText: "First name", prefixIcon: Icon(Icons.perm_identity)),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(
                labelText: "Last name", prefixIcon: Icon(Icons.perm_identity)),
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
                  .signUp(
                      emailController.text.trim(),
                      firstNameController.text.trim(),
                      lastNameController.text.trim(),
                      passwordController.text.trim())
                  .then((value) => showMessage(value));
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
