import 'package:flutter/material.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/screens/film/people_section.dart';

class FilmScreen extends StatefulWidget {
  final String filmId;
  final String title;

  const FilmScreen({Key? key, required this.filmId, required this.title}) : super(key: key);

  @override
  _FilmScreenState createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  final FilmsRepository _repository = FilmsRepository();
  late Future<Film> _filmCall = _repository.fetchFilm(widget.filmId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
          future: _filmCall,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final film = snapshot.data as Film;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(film.description),
                    SizedBox(height: 16),
                    PeopleSection(peopleIds: film.people.map(_getPeopleIdFromUrl).toList()),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  String _getPeopleIdFromUrl(String url) => url.split("/").where((path) => path.isNotEmpty).last;
}
