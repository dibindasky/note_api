import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'view/notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        // appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple,foregroundColor: Colors.white),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: ScreenNotes(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
