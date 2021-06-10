import 'package:flutter/material.dart';
import 'package:riverpod_101/config.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/films_repository..dart';
import 'package:riverpod_101/screens/film/film_screen.dart';
import 'package:riverpod_101/screens/films/film_card.dart';
import 'package:riverpod_101/screens/films/sort_item.dart';

enum Sort { title, date, duration }

class FilmsScreen extends StatefulWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  final FilmsRepository _repository = FilmsRepository();
  late Future<List<Film>> _filmsCall = _repository.fetchFilms();
  List<Film> films = [];
  Sort sortSelected = Sort.date;

  void sort(Sort sortValue) {
    switch (sortValue) {
      case Sort.title:
        films.sort((a, b) => a.title.compareTo(b.title));
        break;
      case Sort.date:
        films.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
        break;
      case Sort.duration:
        films.sort((a, b) => a.runningTime.compareTo(b.runningTime));
        break;
    }
  }

  void _onTap(Sort sortValue) {
    sort(sortValue);

    setState(() {
      sortSelected = sortValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _filmsCall,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          films = snapshot.data as List<Film>;
          sort(sortSelected);

          return Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: Sort.values.map((sortValue) {
                    final onTap = () => _onTap(sortValue);

                    switch (sortValue) {
                      case Sort.title:
                        return SortItem(
                            label: "Title", icon: Icons.title, onTap: onTap, selected: sortSelected == sortValue);
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

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _navigate(Film film) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => FilmScreen(
          title: film.title,
          filmId: film.id,
        ),
      ),
    );
  }
}
