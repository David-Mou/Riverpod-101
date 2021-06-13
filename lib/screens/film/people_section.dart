import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_101/models/people.dart';
import 'package:riverpod_101/repositories/people_repository..dart';
import 'package:riverpod_101/screens/film/people_card.dart';

final _filteredPeopleProvider = FutureProvider.family<List<People>, List<String>>((ref, ids) async {
  final people = await ref.watch(peopleProvider.future);

  if (ids.length == 1 && ids.first == "people") return [];

  return people.where((person) => ids.contains(person.id)).toList();
});

class PeopleSection extends ConsumerWidget {
  final List<String> peopleIds;

  const PeopleSection({Key? key, required this.peopleIds}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final filteredPeople = watch(_filteredPeopleProvider(peopleIds));

    return filteredPeople.when(
      data: (filteredPeople) => _buildSuccess(filteredPeople),
      loading: () => _buildLoading(),
      error: (error, stack) => _buildError(),
    );
  }

  Widget _buildSuccess(List<People> filteredPeople) {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredPeople.length,
        itemBuilder: (context, index) {
          return PeopleCard(people: filteredPeople[index]);
        },
      ),
    );
  }

  Widget _buildError() => Center(child: Text("Oooops! Something bad is happening..."));

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
