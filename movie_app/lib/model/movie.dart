class Movie {
  final int id;
  final String title;
  final double popularity;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;

  Movie(
      {this.id,
      this.backPoster,
      this.overview,
      this.popularity,
      this.poster,
      this.rating,
      this.title});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        backPoster = json['backdrop_path'],
        overview = json['overview'],
        popularity = json['popularity'].toDouble(),
        poster = json['poster_path'],
        rating = json['vote_average'].toDouble(),
        title = json['title'];
}
