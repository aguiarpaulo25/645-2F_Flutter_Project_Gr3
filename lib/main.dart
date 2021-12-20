import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/auth/authentication_service.dart';
import 'package:flutter_project/utils/fetch_data.dart';
import 'package:flutter_project/utils/firebase_service.dart';
import 'package:flutter_project/utils/theme_colors.dart';
import 'package:flutter_project/utils/theme_provider.dart';
import 'package:provider/provider.dart';

import 'auth/authentification_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Verifie que le mode offline est bien activé pour la firebase
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          Provider<FetchData>(
            create: (_) => FetchData(),
          ),
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          Provider<FirebaseService>(
            create: (_) => FirebaseService(),
          ),
          StreamProvider<User?>(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
          ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, model, __) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Welcome',
              theme: ThemeColors.lightTheme,
              darkTheme: ThemeColors.darkTheme,
              themeMode: themeProvider.themeMode,
              home: const AuthenticationWrapper(),
            );
          },
        ));
  }
}
