import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/models/people.dart';
import 'package:riverpod_101/repositories/config.dart';

class PeopleRepository {
  final Dio dio;

  PeopleRepository({required this.dio});

  Future<List<People>> fetchPeople() async {
    final response = await dio.get("people");

    if (response.statusCode == 200) {
      final people = response.data as List<dynamic>;

      return people.map((people) => People.fromJson(people)).toList();
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }
}

final peopleRepositoryProvider = Provider((ref) => PeopleRepository(dio: ref.watch(dioProvider)));

final peopleProvider = FutureProvider<List<People>>((ref) async {
  final repository = ref.watch(peopleRepositoryProvider);

  return await repository.fetchPeople();
});
