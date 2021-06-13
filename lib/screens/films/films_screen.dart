import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/config.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/screens/film/film_screen.dart';
import 'package:riverpod_101/screens/films/film_card.dart';
import 'package:riverpod_101/screens/films/sort_item.dart';

enum Sort { title, date, duration }

final _sortProvider = StateProvider<Sort>((ref) => Sort.date);

final _filmsSortedProvider = FutureProvider.autoDispose<List<Film>>((ref) async {
  final films = await ref.watch(filmsProvider.future);
  final sortValue = ref.watch(_sortProvider).state;

  switch (sortValue) {
    case Sort.title:
      return films..sort((a, b) => a.title.compareTo(b.title));
    case Sort.date:
      return films..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    case Sort.duration:
      return films..sort((a, b) => a.runningTime.compareTo(b.runningTime));
  }
});

class FilmsScreen extends ConsumerWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final films = watch(_filmsSortedProvider);

    return films.when(
      data: (films) => _buildSuccess(watch, films),
      loading: () => _buildLoading(),
      error: (error, stack) => _buildError(),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildSuccess(ScopedReader watch, List<Film> films) {
    final sort = watch(_sortProvider);
    final sortSelected = sort.state;

    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: Sort.values.map((sortValue) {
              final onTap = () => sort.state = sortValue;

              switch (sortValue) {
                case Sort.title:
                  return SortItem(label: "Title", icon: Icons.title, onTap: onTap, selected: sortSelected == sortValue);
                case Sort.date:
                  return SortItem(
                      label: "Date", icon: Icons.date_range, onTap: onTap, selected: sortSelected == sortValue);
                case Sort.duration:
                  return SortItem(
                      label: "Duration", icon: Icons.timer, onTap: onTap, selected: sortSelected == sortValue);
              }
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: films.length,
              itemBuilder: (context, index) {
                final film = films[index];

                return FilmCard(film: film, onTap: () => _navigate(film));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() => Center(child: Text("Oooops! Something bad is happening..."));

  void _navigate(Film film) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => FilmScreen(title: film.title, filmId: film.id),
      ),
    );
  }
}
