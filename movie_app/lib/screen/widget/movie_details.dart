import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/cast_bloc.dart';
import 'package:movie_app/bloc/movie_video_bloc.dart';
import 'package:movie_app/model/MovieVideoResponse.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/model/movieVideo.dart';
import 'package:movie_app/screen/videoPlayer.dart';
import 'package:movie_app/screen/widget/cast_screen.dart';
import 'package:movie_app/screen/widget/movieInfo.dart';
import 'package:movie_app/screen/widget/similar_movie.dart';
import 'package:movie_app/style/theme.dart' as Styler;
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  MovieDetails({@required this.movie});
  @override
  _MovieDetailsState createState() => _MovieDetailsState(movie);
}

class _MovieDetailsState extends State<MovieDetails> {
  final Movie movie;
  _MovieDetailsState(this.movie);
  @override
  void initState() {
    super.initState();
    videoBloc..getVideo(movie.id);
  }

  @override
  void dispose() {
    videoBloc..drainstream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styler.Colors.mainColor,
      body: SliverFab(
        floatingPosition: FloatingPosition(right: 20),
        floatingWidget: StreamBuilder<MovieVideoResponse>(
          stream: videoBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieVideoResponse> snapshot) {
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
        ),
        expandedHeight: 200,
        slivers: [
          SliverAppBar(
            backgroundColor: Styler.Colors.mainColor,
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                // "",
                movie.title.length > 40
                    ? movie.title.substring(0, 34) + "..."
                    : movie.title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://image.tmdb.org/t/p/original/" +
                                movie.backPoster),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0)
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        movie.rating.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      RatingBar(
                        itemSize: 10,
                        initialRating: movie.rating / 2,
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "Overview".toUpperCase(),
                    style: TextStyle(
                        color: Styler.Colors.tertiaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    movie.overview,
                    style: TextStyle(
                        color: Colors.white, fontSize: 12, height: 1.5),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MovieInfo(
                  id: movie.id,
                ),
                CastScreen(
                  id: movie.id,
                ),
                SimilarMovies(
                  id: movie.id,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  _nowPlayngWidget(MovieVideoResponse data) {
    List<MovieVideo> video = data.video;
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayScreen(
                controller: YoutubePlayerController(
                    initialVideoId: video[0].key,
                    flags: YoutubePlayerFlags(autoPlay: true, forceHD: true),),
              ),
            ));
      },
      backgroundColor: Styler.Colors.tertiaryColor,
      child: Icon(Icons.play_arrow),
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
      child: Container(),
    );
  }
}
