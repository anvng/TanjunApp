import 'package:flutter/material.dart';

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
        home: const Text('Tanjun App'),
        debugShowCheckedModeBanner: false);
  }
}
