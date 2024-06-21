import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_ui/pages/base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketing App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff101213),
        textTheme: GoogleFonts.questrialTextTheme(),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: const Color(0xffE52553),
          secondary: const Color(0xff101213),
          tertiary: const Color(0xff2C2C2C),
        ),
        useMaterial3: true,
      ),
      home: const BasePage(),
    );
  }
}
