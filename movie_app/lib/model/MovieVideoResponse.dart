import 'package:movie_app/model/movieVideo.dart';

class MovieVideoResponse {
  final List<MovieVideo> video;
  final String error;

  MovieVideoResponse({this.error, this.video});

  MovieVideoResponse.fromJson(Map<String, dynamic> json)
      : video = (json['results'] as List).map((i) => MovieVideo.fromJson(i)).toList(),
        error = "";

  MovieVideoResponse.withError(String error)
      : video = List(),
        error = error;
}
