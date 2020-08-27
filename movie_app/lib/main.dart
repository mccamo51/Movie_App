import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/screen/home_screen.dart';

void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
