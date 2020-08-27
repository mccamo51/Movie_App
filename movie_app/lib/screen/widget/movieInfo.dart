import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/model/movieDetails.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class MovieInfo extends StatefulWidget {
  final int id;
  MovieInfo({this.id});
  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailsBloc..getMovieDetails(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    movieDetailsBloc..drainstream();
    super.dispose();
  }

  final int id;
  _MovieInfoState(this.id);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailsResponse>(
      stream: movieDetailsBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieDetailsResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data.error.length > 0) {
            return _errorBuildWidget(snapshot.data.error);
          }
          return _nowPlayngWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _errorBuildWidget(snapshot.error);
        } else {
          return _loadingWidget();
        }
      },
    );
  }

  _nowPlayngWidget(MovieDetailsResponse data) {
    MovieDetails details = data.movieDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Budget".toUpperCase(),
                    style: TextStyle(
                        color: Styler.Colors.tertiaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    details.budget.toString() + "\$",
                    style: TextStyle(
                        color: Styler.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Duration".toUpperCase(),
                    style: TextStyle(
                        color: Styler.Colors.tertiaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    details.runtime.toString()+"mins",
                    style: TextStyle(
                        color: Styler.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Release Date".toUpperCase(),
                    style: TextStyle(
                        color: Styler.Colors.tertiaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    details.dateReleased,
                    style: TextStyle(
                        color: Styler.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text(
                "Genre".toUpperCase(),
                style: TextStyle(
                  color: Styler.Colors.tertiaryColor,
                  // fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 35,
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: ListView.builder(
                  itemCount: details.genre.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 2, color: Colors.white)),
                        child: Text(
                          details.genre[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )
      ],
    );
  }

  _errorBuildWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Error occured $error")],
      ),
    );
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
