import 'package:flutter/foundation.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class CastBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<CastResponse> _behaviorSubject =
      BehaviorSubject<CastResponse>();

  getCast(int id) async {
    CastResponse response = await _movieRespository.getCast(id);
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

  BehaviorSubject<CastResponse> get subject => _behaviorSubject;
}

final castBloc = CastBloc();
