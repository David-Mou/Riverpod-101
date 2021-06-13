import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/tools/list_extensions.dart';

import 'director_card.dart';

typedef FilmsByDirector = List<List<Film>>;

final _directorsProvider = FutureProvider<FilmsByDirector>((ref) async {
  final films = await ref.watch(filmsProvider.future);

  return films.groupBy((film) => film.director).values.toList();
});

class DirectorsScreen extends ConsumerWidget {
  const DirectorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final directors = watch(_directorsProvider);

    return directors.when(
      data: _buildSuccess,
      loading: _buildLoading,
      error: (error, stack) => _buildError(),
    );
  }

  Widget _buildSuccess(FilmsByDirector filmsByDirector) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: filmsByDirector.length,
      itemBuilder: (context, index) {
        return DirectorCard(films: filmsByDirector[index]);
      },
    );
  }

  Widget _buildError() => Center(child: Text("Oooops! Something bad is happening..."));

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
