import 'package:flutter/material.dart';
import 'package:riverpod_101/models/film.dart';

typedef OnCardTapped = void Function();

class FilmCard extends StatelessWidget {
  final Film film;
  final OnCardTapped onTap;

  const FilmCard({Key? key, required this.film, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(film.title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(film.director, style: TextStyle(fontStyle: FontStyle.italic)),
              SizedBox(height: 4),
              Text(film.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: Text('${film.releaseDate} - ${film.runningTime} min')),
            ],
          ),
        ),
      ),
    );
  }
}
