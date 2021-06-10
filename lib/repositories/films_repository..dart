import 'dart:io';

import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/config.dart';

class FilmsRepository {
  Future<List<Film>> fetchFilms() async {
    final response = await dio.get("https://ghibliapi.herokuapp.com/films");

    if (response.statusCode == 200) {
      final films = response.data as List<dynamic>;

      return films.map((film) => Film.fromJson(film)).toList();
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }

  Future<Film> fetchFilm(String filmId) async {
    final response = await dio.get("https://ghibliapi.herokuapp.com/films/$filmId");

    if (response.statusCode == 200) {
      return Film.fromJson(response.data);
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }
}
