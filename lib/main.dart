import 'package:flutter/material.dart';
import 'package:test_task/wiki_search_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiki Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: 1),
          headline6: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              color: Colors.grey,
              letterSpacing: 1),
        ),
      ),
      home: WikiSearchRoute(),
    );
  }
}
