import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/models/film.dart';
import 'package:riverpod_101/repositories/config.dart';

class FilmsRepository {
  final Dio dio;

  FilmsRepository({required this.dio});

  Future<List<Film>> fetchFilms() async {
    final response = await dio.get("films");

    if (response.statusCode == 200) {
      final films = response.data as List<dynamic>;

      return films.map((film) => Film.fromJson(film)).toList();
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }

  Future<Film> fetchFilm(String filmId) async {
    final response = await dio.get("films/$filmId");

    if (response.statusCode == 200) {
      return Film.fromJson(response.data);
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }
}

final filmsRepositoryProvider = Provider((ref) => FilmsRepository(dio: ref.watch(dioProvider)));

final filmsProvider = FutureProvider<List<Film>>((ref) async {
  final repository = ref.watch(filmsRepositoryProvider);

  return await repository.fetchFilms();
});

final filmProvider = FutureProvider.family<Film, String>((ref, id) async {
  final repository = ref.watch(filmsRepositoryProvider);

  return await repository.fetchFilm(id);
});
