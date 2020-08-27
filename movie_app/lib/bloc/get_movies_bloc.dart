import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesListBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<MovieResponse> _behaviorSubject =
      BehaviorSubject<MovieResponse>();
  getMovie() async {
    MovieResponse response = await _movieRespository.getMovies();
    _behaviorSubject.sink.add(response);
  }

  dispose() {
    _behaviorSubject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _behaviorSubject;
}
final moviesBloc = MoviesListBloc();
