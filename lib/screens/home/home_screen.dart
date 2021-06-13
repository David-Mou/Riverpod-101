import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/screens/directors/directors_screen.dart';
import 'package:riverpod_101/screens/films/films_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const int BOOKS_POSITION = 0;
const int AUTHOR_POSITION = 1;

class _HomeScreenState extends State<HomeScreen> {
  late int _index;

  final _screens = [
    FilmsScreen(),
    DirectorsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _index = BOOKS_POSITION;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod 101"),
        actions: [IconButton(onPressed: () => context.refresh(filmsProvider), icon: Icon(Icons.refresh))],
      ),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _index = index),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Films"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Directors"),
        ],
      ),
    );
  }
}
