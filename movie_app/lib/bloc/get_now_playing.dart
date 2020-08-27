import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class NowPlayingListBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<MovieResponse> _behaviorSubject =
      BehaviorSubject<MovieResponse>();
  getNowPlaying() async {
    MovieResponse response = await _movieRespository.getPlayingMovies();
    _behaviorSubject.sink.add(response);
  }

  dispose() {
    _behaviorSubject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _behaviorSubject;
}
final nowPlayingBloc = NowPlayingListBloc();
