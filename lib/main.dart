import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/cars_feed_page.dart';
import 'repository/abstract/cars_feed_repository.dart';
import 'repository/concrete/http_cars_feed_repository.dart';
import 'repository/dio/utils.dart';
import 'service/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator(await SharedPreferences.getInstance());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dryve',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0065ff),
        fontFamily: 'CircularStd',
        textTheme: const TextTheme(
          bodyText2: TextStyle(letterSpacing: -0.5),
        ),
        scaffoldBackgroundColor: Colors.white,
        unselectedWidgetColor: const Color(0xFFa5abb7),
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
