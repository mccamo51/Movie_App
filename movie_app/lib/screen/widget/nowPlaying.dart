import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/bloc/get_now_playing.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/style/theme.dart' as Styler;
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
    nowPlayingBloc..getNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: nowPlayingBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _errorBuildWidget(snapshot.data.error);
            }
            return _nowPlayngWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _errorBuildWidget(snapshot.data.error);
          } else {
            return _loadingWidget();
          }
        });
  }

  _nowPlayngWidget(MovieResponse data) {
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
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5),
          length: movies.take(5).length,
          indicatorColor: Styler.Colors.tertiaryColor,
          indicatorSelectorColor: Styler.Colors.mainColor,
          shape: IndicatorShape.circle(size: 8.0),
          child: PageView.builder(
              itemCount: movies.take(5).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +
                                    movies[index].backPoster,
                              ),
                              fit: BoxFit.cover),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Styler.Colors.mainColor.withOpacity(1.0),
                                Styler.Colors.secondColor.withOpacity(0.0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 0.9])),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.play_circle_outline,
                          color: Styler.Colors.tertiaryColor,
                          size: 50,
                        ),
                        onPressed: null,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      );
    }
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
