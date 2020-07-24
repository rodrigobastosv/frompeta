import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'page/cars_feed_page.dart';
import 'repository/abstract/cars_feed_repository.dart';
import 'repository/concrete/http_cars_feed_repository.dart';
import 'repository/dio/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0065ff),
        fontFamily: 'CircularStd',
        textTheme: TextTheme(
          bodyText2: TextStyle(letterSpacing: -0.5),
        ),
        scaffoldBackgroundColor: Colors.white,
        unselectedWidgetColor: Color(0xFFa5abb7),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CarsFeedRepository>(
            create: (_) => HttpCarsFeedRepository(
              client: getDefaultClient(),
            ),
          ),
        ],
        child: CarsFeedPage(),
      ),
    );
  }
}
