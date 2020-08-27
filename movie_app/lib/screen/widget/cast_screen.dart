import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/cast_bloc.dart';
import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/style/theme.dart' as Styler;

class CastScreen extends StatefulWidget {
  final int id;
  CastScreen({this.id});
  @override
  _CastScreenState createState() => _CastScreenState(id);
}

class _CastScreenState extends State<CastScreen> {
  final int id;
  _CastScreenState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    castBloc..getCast(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    castBloc..drainstream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            "Cast".toUpperCase(),
            style: TextStyle(
              color: Styler.Colors.tertiaryColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder<CastResponse>(
          stream: castBloc.subject.stream,
          builder: (context, AsyncSnapshot<CastResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data.error.length > 0) {
                return _errorBuildWidget(snapshot.data.error);
              }
              return _castWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _errorBuildWidget(snapshot.error);
            } else {
              return _loadingWidget();
            }
          },
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

  _castWidget(CastResponse data) {
    List<Cast> cast = data.cast;
    return Container(
      height: 140,
      child: ListView.builder(
          itemCount: cast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: 100,
              child: GestureDetector(
                onTap: null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w300/"+
                                    cast[index].img),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      cast[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(cast[index].character, style: TextStyle(color: Styler.Colors.tertiaryColor, fontSize: 9),textAlign: TextAlign.center,)
                  ],
                ),
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
}
