import 'package:flutter/material.dart';
import 'package:riverpod_101/config.dart';
import 'package:riverpod_101/screens/home/home_screen.dart';

void main() {
  runApp(Riverpod101App());
}

class Riverpod101App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod 101',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
