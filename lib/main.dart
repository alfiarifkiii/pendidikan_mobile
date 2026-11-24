import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const KidsSmartApp());
}

class KidsSmartApp extends StatelessWidget {
  const KidsSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KidsSmart',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFA),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F3FF),
          foregroundColor: Color(0xFF2D264B),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF2D264B),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
