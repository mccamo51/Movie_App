import 'package:flutter/foundation.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailsBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<MovieDetailsResponse> _behaviorSubject =
      BehaviorSubject<MovieDetailsResponse>();

  getMovieDetails(int id) async {
    MovieDetailsResponse response = await _movieRespository.getMovieDetails(id);
    _behaviorSubject.sink.add(response);
  }

  void drainstream() {
    _behaviorSubject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _behaviorSubject.drain();
    _behaviorSubject.close();
  }
  BehaviorSubject<MovieDetailsResponse> get subject => _behaviorSubject;
}

final movieDetailsBloc = MovieDetailsBloc();
