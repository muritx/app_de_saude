import 'package:app_de_saude/forget_password.dart';
import 'package:app_de_saude/forget_password.dart';
import 'package:app_de_saude/scr_main_menu.dart';
import 'package:app_de_saude/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: const LoginScreen(),
    );
  }
}