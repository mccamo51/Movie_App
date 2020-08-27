import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screen/widget/genre.dart';
import 'package:movie_app/screen/widget/nowPlaying.dart';
import 'package:movie_app/screen/widget/person.dart';
import 'package:movie_app/screen/widget/top_ratedMovies.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styler.Colors.mainColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Styler.Colors.mainColor,
        title: Text("Movie App",
            style: TextStyle(color: Colors.white,)),
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          GenreScreen(),
          PersonTrending(),
          TopRatedMovies()
        ],
      ),
    );
  }
}
