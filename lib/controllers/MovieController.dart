
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/Movie.dart';
import '../models/MovieData.dart';
import '../utils/Common.dart';

class MovieController extends GetxController {

  late Box<Movie> movieBox;
  late Box<String> genresBox;

  MovieController({required this.movieBox, required this.genresBox});


  RxBool isLoading = true.obs;
  RxList<Movie> movies = <Movie>[].obs;
  RxList<String> genres = <String>[].obs;
  RxString error = ''.obs;
  RxInt selectedGenericIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    // Initialize Hive boxes here if needed
    // e.g., movieBox = await Hive.openBox<Movie>('movies');
    // genresBox = await Hive.openBox<String>('genres');
    fetchMovies();
  }

  // Define the function to be tested


  Rx<Movie> getMovieById(int id) {
    try {
      return Rx<Movie>(movies.firstWhere((movie) => movie.id == id));
    } catch (e) {
      return Rx<Movie>(Movie(
        id: -1,
        title: 'Not Found',
        year: '',
        runtime: '',
        genres: [],
        director: '',
        actors: '',
        plot: 'Movie not found!',
        posterUrl: '',
      ));
    }
  }


  Future<void> fetchMovies({http.Client? httpClient}) async {
    // Check if the data is already cached
    if (genresBox.isNotEmpty && movieBox.isNotEmpty) {
      genres.assignAll(genresBox.values.toList());
      movies.assignAll(movieBox.values.toList());
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(Uri.parse(Common.BASE_URL));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        MovieData movieData = MovieData.fromJson(data);
        print('dskflsdh ${data}');
        if (movieData.movies != null) {
          movies.assignAll(movieData.movies!);
          genres.assignAll(movieData.genres!);
          print('dskflsdh ${genres.length}');
          // Cache the fetched movies and genres in Hive
          await movieBox.clear();
          await genresBox.clear();
          await movieBox.addAll(movieData.movies!);
          await genresBox.addAll(movieData.genres!);
        } else {
          // Handle error cases here
          error.value = 'Failed to parse movies data';
        }
      } else {
        // Handle error cases here
        error.value = 'Failed to fetch movies';
      }
    } catch (e) {
      // Handle error cases here
      error.value = 'Error occurred while fetching movies';

    } finally {
      isLoading.value = false;
    }
  }

  selectedGeneric(int selectedGenericIndex){
    this.selectedGenericIndex.value = selectedGenericIndex;

    update();
  }


  @override
  void onClose() {
    movieBox.close();
    genresBox.close();
    super.onClose();
  }
}
