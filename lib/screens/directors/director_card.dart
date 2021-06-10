import 'package:flutter/material.dart';
import 'package:riverpod_101/models/film.dart';

class DirectorCard extends StatelessWidget {
  final List<Film> films;

  const DirectorCard({Key? key, required this.films}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(films.first.director, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: films.map((film) => Text(film.title)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
