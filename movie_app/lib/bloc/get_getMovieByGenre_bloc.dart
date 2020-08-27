import 'package:flutter/material.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieByGenreListBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<MovieResponse> _behaviorSubject =
      BehaviorSubject<MovieResponse>();
  getMovieByGenres(int id) async {
    MovieResponse response = await _movieRespository.getMovieByGenres(id);
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

  BehaviorSubject<MovieResponse> get subject => _behaviorSubject;
}

final movieByGenre = MovieByGenreListBloc();
