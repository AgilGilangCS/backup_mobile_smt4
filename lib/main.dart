import 'package:flutter/material.dart';
import 'screens_meja/form_meja.dart';
import 'screens_meja/meja.dart';
import 'screens_meja/edit_meja.dart';
import 'screens_meja/detail_meja.dart';
import 'homes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:intl/intl.dart';
import 'splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keren',
      home: SplashScreen(),
    );
  }
}
