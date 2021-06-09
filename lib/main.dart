import 'package:flutter/material.dart';

void main() {
  runApp(Riverpod101App());
}

class Riverpod101App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod 101',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riverpod 101")),
      body: Center(child: Text("App goes here")),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Author"),
        ],
      ),
    );
  }
}
