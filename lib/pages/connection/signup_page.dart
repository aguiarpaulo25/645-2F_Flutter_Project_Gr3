import 'package:easy_localization/src/public_ext.dart';
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
        title: const Text("CreateAccount").tr(),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: "Email".tr(), prefixIcon: const Icon(Icons.email)),
          ),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
                labelText: "FirstName".tr(),
                prefixIcon: const Icon(Icons.perm_identity)),
          ),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
                labelText: "LastName".tr(),
                prefixIcon: const Icon(Icons.perm_identity)),
          ),
          TextField(
              obscureText: _obscureText,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password".tr(),
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
            child: const Text("Create").tr(),
          ),
        ],
      ),
    );
  }
}
