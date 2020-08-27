import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_getMovieByGenre_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/screen/widget/movie_details.dart';
import 'package:movie_app/style/theme.dart' as Styler;
import 'package:page_indicator/page_indicator.dart';

class GenreMovie extends StatefulWidget {
  final int genId;
  GenreMovie({@required this.genId});
  @override
  _GenreMovieState createState() => _GenreMovieState();
}

class _GenreMovieState extends State<GenreMovie> {
  final int genId;
  _GenreMovieState({this.genId});
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // TODO: implement initState
    super.initState();
    movieByGenre..getMovieByGenres(widget.genId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: movieByGenre.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _errorBuildWidget(snapshot.data.error);
            }
            return _nowGenreByMovieWidget(snapshot.data);
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

  _nowGenreByMovieWidget(MovieResponse data) {
    List<Movie> movies = data.movie;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("No Movie")],
        ),
      );
    } else {
      return Container(
        height: 270,
        child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (contex, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    // print(movies[index].backPoster);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(movie: movies[index])));
                  },
                  child: Column(
                    children: [
                      movies[index].poster == null
                          ? Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Styler.Colors.secondColor,
                                borderRadius: BorderRadius.circular(2),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    EvaIcons.filmOutline,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              height: 180,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200" +
                                            movies[index].poster,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            movies[index].rating.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RatingBar(
                            itemSize: 8,
                            initialRating: movies[index].rating / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (context, index) => Icon(
                              EvaIcons.star,
                              color: Styler.Colors.secondColor,
                            ),
                            onRatingUpdate: (value) {
                              print(value);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    }
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
