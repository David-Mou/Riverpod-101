import 'dart:io';

import 'package:riverpod_101/models/people.dart';
import 'package:riverpod_101/repositories/config.dart';

class PeopleRepository {
  Future<List<People>> fetchPeople() async {
    final response = await dio.get("https://ghibliapi.herokuapp.com/people");

    if (response.statusCode == 200) {
      final people = response.data as List<dynamic>;

      return people.map((people) => People.fromJson(people)).toList();
    }

    throw HttpException(response.statusMessage ?? 'No message');
  }
}
