class Film {
  final String id;
  final String title;
  final String description;
  final String director;
  final int releaseDate;
  final int runningTime;
  final List<String> people;
  final String url;

  Film({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.releaseDate,
    required this.runningTime,
    required this.people,
    required this.url,
  });

  factory Film.fromJson(Map<String, dynamic> json) => Film(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        director: json['director'],
        releaseDate: int.parse(json['release_date']),
        runningTime: int.parse(json['running_time']),
        people: json['people'].map<String>((people) => people as String).toList(),
        url: json['url'],
      );
}
