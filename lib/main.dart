import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();

  //Verifie que le mode offline est bien activé pour la firebase
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    refreshUI(context);

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
          ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider())
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
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: const AuthenticationWrapper(),
            );
          },
        ));
  }

  void refreshUI(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
