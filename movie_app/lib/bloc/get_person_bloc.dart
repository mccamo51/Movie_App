import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonListBloc {
  final MovieRespository _movieRespository = MovieRespository();
  final BehaviorSubject<PersonResponse> _behaviorSubject =
      BehaviorSubject<PersonResponse>();
  getPerson() async {
    PersonResponse response = await _movieRespository.getPerson();
    _behaviorSubject.sink.add(response);
  }

  dispose() {
    _behaviorSubject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _behaviorSubject;
}
final personBloc = PersonListBloc();
