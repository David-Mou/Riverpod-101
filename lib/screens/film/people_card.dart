import 'package:flutter/material.dart';
import 'package:riverpod_101/models/people.dart';

class PeopleCard extends StatelessWidget {
  final People people;

  const PeopleCard({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(people.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Align(alignment: Alignment.centerRight, child: Text('${people.age} years old')),
          ],
        ),
      ),
    );
  }
}
