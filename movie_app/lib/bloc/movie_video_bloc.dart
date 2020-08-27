import 'package:flutter/foundation.dart';
import 'package:movie_app/model/MovieVideoResponse.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class VideoBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<MovieVideoResponse> _behaviorSubject =
      BehaviorSubject<MovieVideoResponse>();
  getVideo(int id) async {
    MovieVideoResponse response = await _movieRespository.getVideo(id);
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


  BehaviorSubject<MovieVideoResponse> get subject => _behaviorSubject;
}
final videoBloc = VideoBloc();