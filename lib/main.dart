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
