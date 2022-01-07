import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  void showMessage(status, message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(status),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Contact").tr(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "ContactText".tr(),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          TextField(
            controller: subjectController,
            decoration: InputDecoration(
              labelText: "Subject".tr(),
              prefixIcon: const Icon(Icons.assignment_outlined),
            ),
          ),
          TextField(
            controller: messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: "Message".tr(),
              prefixIcon: const Icon(Icons.article),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                launchEmail(
                  email: FirebaseAuth.instance.currentUser!.email.toString(),
                  subject: subjectController.text,
                  message: messageController.text,
                );
              },
              child: const Text("Send").tr(),
              style: Theme.of(context).elevatedButtonTheme.style,
            ),
          ),
        ],
      ),
    );
  }

  Future launchEmail({
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_vg0dtjy';
    const templateId = 'template_h20xe2s';
    const userId = 'user_KyXryCtOSmIk5nVYcsnSx';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    if (subject.isEmpty) {
      showMessage("ContactError".tr(), "ContactEmptySubject".tr());
    } else if (message.isEmpty) {
      showMessage("ContactError".tr(), "ContactEmptyMessage".tr());
    } else {
      final response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'user_email': email,
              'user_subject': subject,
              'user_message': message,
            }
          }));
      subjectController.clear();
      messageController.clear();
      if (response.body != "OK") {
        showMessage("ContactError".tr(), "ContactSendError".tr());
      } else {
        showMessage("ContactSuccess".tr(), "ContactSendSuccess".tr());
      }
    }
  }
}
