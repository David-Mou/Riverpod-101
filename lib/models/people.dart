class People {
  final String id;
  final String name;
  final String age;

  People({
    required this.id,
    required this.name,
    required this.age,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
        id: json['id'],
        name: json['name'],
        age: json['age'],
      );
}
