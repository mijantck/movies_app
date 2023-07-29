import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/controllers/MovieController.dart'; // Correct import statement
import 'package:movies_app/utils/AppString.dart';
import 'package:movies_app/views/DetailedViewScreen.dart';
import 'package:movies_app/views/LoadingScreen.dart';
import 'package:movies_app/views/MovieListScreen.dart';
import 'package:http/http.dart' as http;

import 'models/Movie.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Hive.initFlutter(); // Initialize Hive for Flutter
  Hive.registerAdapter(MovieAdapter()); // Register the Hive adapter for Movie
  await Hive.openBox<Movie>('movies');
  Get.testMode = true;
  final Box<Movie> movieBox = await Hive.openBox<Movie>('movies');
  final Box<String> genresBox = await Hive.openBox<String>('genres');// Open the Hive box for Movie
  runApp(MyApp( movieBox: movieBox, genresBox: genresBox));
}

class MyApp extends StatelessWidget {

  final Box<Movie> movieBox;
  final Box<String> genresBox;

  MyApp({ required this.movieBox, required this.genresBox});


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.APP_NAME,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoadingScreen()),
        GetPage(name: '/movie_list', page: () => MovieListScreen()),
        GetPage(name: '/detailed_view', page: () => DetailedViewScreen()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put<MovieController>(MovieController(movieBox: movieBox, genresBox: genresBox));
      }),
    );
  }
}
