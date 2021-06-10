import 'package:flutter/material.dart';
import 'package:riverpod_101/models/people.dart';
import 'package:riverpod_101/repositories/people_repository..dart';
import 'package:riverpod_101/screens/film/people_card.dart';

class PeopleSection extends StatefulWidget {
  final List<String> peopleIds;

  const PeopleSection({Key? key, required this.peopleIds}) : super(key: key);

  @override
  _PeopleSectionState createState() => _PeopleSectionState();
}

class _PeopleSectionState extends State<PeopleSection> {
  final PeopleRepository _peopleRepository = PeopleRepository();
  late final Future<List<People>> peopleCall = _peopleRepository.fetchPeople();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: peopleCall,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final people = snapshot.data as List<People>;
          final filteredPeople = _filterPeople(people);

          return Expanded(
            child: ListView.builder(
              itemCount: filteredPeople.length,
              itemBuilder: (context, index) {
                return PeopleCard(people: filteredPeople[index]);
              },
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  List<People> _filterPeople(List<People> people) {
    if (widget.peopleIds.length == 1 && widget.peopleIds.first == "people") return [];

    return people.where((person) => widget.peopleIds.contains(person.id)).toList();
  }
}
