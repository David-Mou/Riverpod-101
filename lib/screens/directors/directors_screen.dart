import 'package:flutter/material.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/tools/list_extensions.dart';

import 'director_card.dart';

class DirectorsScreen extends StatefulWidget {
  const DirectorsScreen({Key? key}) : super(key: key);

  @override
  _DirectorsScreenState createState() => _DirectorsScreenState();
}

class _DirectorsScreenState extends State<DirectorsScreen> {
  final FilmsRepository _repository = FilmsRepository();
  late final Future<List<Film>> _filmsCall = _repository.fetchFilms();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _filmsCall,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final films = (snapshot.data as List<Film>).groupBy((film) => film.director).values.toList();

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: films.length,
            itemBuilder: (context, index) {
              return DirectorCard(films: films[index]);
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}