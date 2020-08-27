import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class GenreListBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<GenreResponse> _behaviorSubject =
      BehaviorSubject<GenreResponse>();
  getGenres() async {
    GenreResponse response = await _movieRespository.getGenres();
    _behaviorSubject.sink.add(response);
  }

  dispose() {
    _behaviorSubject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _behaviorSubject;
}
final genresBloc = GenreListBloc();