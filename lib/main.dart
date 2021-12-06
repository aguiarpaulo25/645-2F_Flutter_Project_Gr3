import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/auth/authentication_service.dart';
import 'package:flutter_project/utils/theme_color.dart';
import 'package:flutter_project/utils/theme_service.dart';
import 'package:provider/provider.dart';

import 'auth/authentification_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _notifier =
      ValueNotifier<ThemeService>(ThemeService(mode: ThemeMode.light));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider<User?>(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
          ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService())
        ],
        child: Consumer<ThemeService>(
          builder: (_, model, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Welcome',
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: model.mode,
              home: const AuthenticationWrapper(),
            );
          },
        ));
  }
}
