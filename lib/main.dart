import 'package:flutter/material.dart';
import 'package:tanjun_app/modules/views/home_screen.dart';

void main() {
  runApp(const TanjunApp());
}

class TanjunApp extends StatelessWidget {
  const TanjunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tanjun App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false);
  }
}
