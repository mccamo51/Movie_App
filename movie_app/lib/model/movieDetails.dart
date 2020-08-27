import 'package:movie_app/model/genre.dart';

class MovieDetails {
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genre;
  final String dateReleased;
  final int runtime;

  MovieDetails({
    this.adult,
    this.budget,
    this.dateReleased,
    this.genre,
    this.id,
    this.runtime,
  });

  MovieDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        adult = json['adult'],
        dateReleased = json['release_date'],
        runtime = json['runtime'],
        genre = (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
        budget = json['budget'];
}
