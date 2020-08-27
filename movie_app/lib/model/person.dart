class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileTag;
  final String known;

  Person({
    this.id,
    this.name,
    this.profileTag,
    this.popularity,
    this.known,
  });

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        profileTag = json['profile_path'],
        name = json['name'],
        popularity = json['popularity'],
        known = json['known_for _department'];
}
