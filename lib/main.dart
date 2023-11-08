import 'package:flutter/material.dart';
import 'package:projet/Widgets/auth_verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
 MaterialApp(
    theme: ThemeData(
      appBarTheme: const AppBarTheme(elevation: 0),
    useMaterial3: true,
     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(background: Colors.red.shade50),
     scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  ),
      home: const AuthVerify(),
    ),
  );
}

