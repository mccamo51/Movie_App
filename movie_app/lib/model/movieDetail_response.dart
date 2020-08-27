import 'package:movie_app/model/movieDetails.dart';

class MovieDetailsResponse {
  final MovieDetails movieDetails;
  final String error;
  MovieDetailsResponse({this.movieDetails, this.error});

  MovieDetailsResponse.fromJson(Map<String, dynamic> json)
      : movieDetails = MovieDetails.fromJson(json),
        error = '';

  MovieDetailsResponse.withError(String errorValue)
      : movieDetails = MovieDetails(
            adult: null,
            budget: null,
            genre: null,
            dateReleased: "null",
            id: null,
            runtime: null),
        error = errorValue;
}
