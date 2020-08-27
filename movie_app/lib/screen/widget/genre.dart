import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/bloc/get_genre_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/screen/widget/genreList.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
     SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _errorBuildWidget(snapshot.data.error);
            } else {
              return _nowGenreWidget(snapshot.data);
              // return Text(snapshot.data.genre.length.toString());
            }
          } else if (snapshot.hasError) {
            return _errorBuildWidget(snapshot.data.error);
          } else {
            return _loadingWidget();
          }
        });
  }

  _errorBuildWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Error occured $error")],
      ),
    );
  }

  Widget _nowGenreWidget(GenreResponse data) {
    List<Genre> genre = data.genre;
    if (genre.length == 0) {
      return Container(
        child: Text("No Genre"),
      );
    } else
      return
          GenreList(genre: genre);
  }

  _loadingWidget() {
    return Center(
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Styler.Colors.secondColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              animating: true,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}
