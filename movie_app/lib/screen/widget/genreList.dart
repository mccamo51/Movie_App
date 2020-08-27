import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/bloc/get_getMovieByGenre_bloc.dart';
import 'package:movie_app/bloc/get_movies_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/style/theme.dart' as Styler;

import 'genreMovies.dart';

class GenreList extends StatefulWidget {
  final List<Genre> genre;
  GenreList({@required this.genre});
  @override
  _GenreListState createState() => _GenreListState(genre);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;
  _GenreListState(this.genres);

  @override
  void initState() {
         SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        movieByGenre..drainstream();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Styler.Colors.mainColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Styler.Colors.mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Styler.Colors.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Styler.Colors.tertiaryColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15, top: 10),
                    child: Text(genre.name.toUpperCase()),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres
                  .map((Genre genre) => GenreMovie(
                        genId: genre.id,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
