import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/intro_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/home_screen.dart';

bool showOnboarding = true;
bool loggedIn = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');

    final prefs = await SharedPreferences.getInstance();
    showOnboarding = prefs.getBool('ON_BOARDING') ?? true;
    loggedIn = prefs.getBool('isLoggedIn') ?? false;
  } catch (e) {
    print('Firebase initialization error: $e');
    // Set default values if initialization fails
    showOnboarding = true;
    loggedIn = false;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget initialScreen;

    if (showOnboarding) {
      initialScreen = const FancyOnBoarding();
    } else if (loggedIn) {
      initialScreen = const HomeScreen();
    } else {
      initialScreen = const AuthScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galleria App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: initialScreen,
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
