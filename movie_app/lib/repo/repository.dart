import 'dart:async';

import 'package:dio/dio.dart';
import 'package:movie_app/model/MovieVideoResponse.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';

class MovieRespository {
  static String apiKey = "0024d8e9c13f48fb4619258007a98261";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio dio = Dio();
  var getPopular =
      "$mainUrl/movie/top_rated?api_key=$apiKey&language=en-US&page=1";
  var getMovieUrl =
      "$mainUrl/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
  var getPlayingUrl = "$mainUrl/movie/now_playing?api_key=$apiKey";
  var getGenreUrl = "$mainUrl/genre/movie/list?api_key=$apiKey";
  var getPersonUrl = "$mainUrl/trending/person/day?api_key=$apiKey";

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response = await dio.get(getPopular, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    try {
      Response response = await dio.get(getPlayingUrl);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<GenreResponse> getGenres() async {
    try {
      Response response = await dio.get(getGenreUrl);
      // print("==================${response.data}");
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return GenreResponse.withError(error);
    }
  }

  Future<PersonResponse> getPerson() async {
    try {
      Response response = await dio.get(getPersonUrl);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError(error);
    }
  }

  Future<MovieResponse> getMovieByGenres(int id) async {
    try {
      Response response = await dio.get("$getMovieUrl&with_genres=$id");
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieDetailsResponse> getMovieDetails(int id) async {
    try {
      Response response =
          await dio.get("$mainUrl/movie/$id?api_key=$apiKey&language=en-US");
      return MovieDetailsResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieDetailsResponse.withError(error);
    }
  }

  Future<CastResponse> getCast(int id) async {
    try {
      Response response = await dio
          .get("$mainUrl/movie/$id/credits?api_key=$apiKey")
          .timeout(Duration(seconds: 15));
      // print(response.data);
      return CastResponse.fromJson(response.data);
    } on TimeoutException catch (t) {
      print(t.toString());
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return CastResponse.withError(error);
    }
  }

  Future<MovieResponse> getSimilarMovie(int id) async {
    try {
      Response response = await dio.get("$mainUrl/movie/$id/similar?api_key=$apiKey&language=en-US&page=1");
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieVideoResponse> getVideo(int id) async {
    try {
      Response response = await dio
          .get("$mainUrl/movie/$id/videos?api_key=$apiKey&language=en-US");
      return MovieVideoResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieVideoResponse.withError(error);
    }
  }
}
