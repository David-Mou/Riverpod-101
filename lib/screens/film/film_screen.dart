import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/screens/film/people_section.dart';

class FilmScreen extends ConsumerWidget {
  final String filmId;
  final String title;

  const FilmScreen({Key? key, required this.filmId, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final film = watch(filmProvider(filmId));

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: film.when(
        data: (film) => _buildSuccess(film),
        loading: () => _buildLoading(),
        error: (error, stack) => _buildError(),
      ),
    );
  }

  Widget _buildSuccess(Film film) {
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

  Widget _buildError() => Center(child: Text("Oooops! Something bad is happening..."));

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  String _getPeopleIdFromUrl(String url) => url.split("/").where((path) => path.isNotEmpty).last;
}
