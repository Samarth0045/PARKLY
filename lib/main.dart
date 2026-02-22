import 'package:flutter/material.dart';
import 'package:parkly_app/logic/provider/auth_provider.dart';
import 'package:parkly_app/presentation/screens/login_screen.dart';
import 'package:parkly_app/presentation/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
