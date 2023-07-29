import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/controllers/MovieController.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/views/DetailedViewScreen.dart';

// Mock your dependencies (e.g., MovieController)
class MockMovieController extends Mock implements MovieController {}

void main() {
  Get.testMode = true;

  group('DetailedViewScreen', () {
    late MockMovieController mockMovieController;

    setUp(() {
      mockMovieController = MockMovieController();
      //Get.put<MovieController>(mockMovieController);
    });

    testWidgets('Should display movie details', (WidgetTester tester) async {
      // Mock the movie data
      final movieId = 1;
      final mockMovie = Movie(
        id: movieId,
        title: 'Beetlejuice',
        year: '1988',
        runtime: '92',
        genres: ['Comedy', 'Fantasy'],
        director: 'Tim Burton',
        actors: 'Alec Baldwin, Geena Davis, Annie McEnroe, Maurice Page',
        plot:
        'A couple of recently deceased ghosts contract the services of a "bio-exorcist" in order to remove the obnoxious new owners of their house.',
        posterUrl:
        'https://images-na.ssl-images-amazon.com/images/M/MV5BMTUwODE3MDE0MV5BMl5BanBnXkFtZTgwNTk1MjI4MzE@._V1_SX300.jpg',
      );
      when(mockMovieController.getMovieById(movieId))
          .thenReturn(Rx<Movie>(mockMovie));

      await tester.pumpWidget(GetMaterialApp(
        home: DetailedViewScreen(movieId: movieId),
      ));

      // Verify that the movie details are displayed correctly
      expect(find.text(mockMovie.title), findsOneWidget);
      expect(find.text(mockMovie.year), findsOneWidget);
      expect(find.text(mockMovie.director), findsOneWidget);
      expect(find.text(mockMovie.actors), findsOneWidget);
      expect(find.text(mockMovie.plot), findsOneWidget);
      // Add more checks for other details as needed
    });

    testWidgets('Should display error if movie not found', (WidgetTester tester) async {
      final mockMovieController = MockMovieController();

      // Set the movie ID to the mock movie ID
      final int movieId = 1;

      // Mock the getMovieById method to return a nullable Rx<Movie>
      when(mockMovieController.getMovieById(movieId));

      await tester.pumpWidget(
        GetMaterialApp(
          home: DetailedViewScreen(movieId: movieId),
          getPages: [GetPage(name: '/', page: () => DetailedViewScreen(movieId: movieId))],
        ),
      );

          // Verify that the error message is displayed
          expect(find.text('Error'), findsOneWidget);
          expect(find.text('Movie not found!'), findsOneWidget);
        });
  });
}
