import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_person_bloc.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class PersonTrending extends StatefulWidget {
  @override
  _PersonTrendingState createState() => _PersonTrendingState();
}

class _PersonTrendingState extends State<PersonTrending> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personBloc..getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Text(
            "Trending Persons for the week".toUpperCase(),
            style: TextStyle(
                color: Styler.Colors.secondColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StreamBuilder(
            stream: personBloc.subject.stream,
            builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _errorBuildWidget(snapshot.data.error);
                } else {
                  return _personWidget(snapshot.data);
                  // return Text(snapshot.data.genre.length.toString());
                }
              } else if (snapshot.hasError) {
                return _errorBuildWidget(snapshot.data.error);
              } else {
                return _loadingWidget();
              }
            }),
      ],
    );
  }

  _personWidget(PersonResponse data) {
    List<Person> _person = data.person;
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 140,
      child: ListView.builder(
          itemCount: _person.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _person[index].profileTag == null
                      ? Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styler.Colors.secondColor),
                          child:
                              Icon(EvaIcons.personOutline, color: Colors.white),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200" +
                                          _person[index].profileTag),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 10,),
                        Text(_person[index].name, style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          height: 1.5,
                          fontWeight: FontWeight.bold
                        ),textAlign: TextAlign.center,)
                ],
              ),
            );
          }),
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

  _errorBuildWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Error occured $error")],
      ),
    );
  }
}
