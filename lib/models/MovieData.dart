import 'Movie.dart';

class MovieData {
  List<String>? genres;
  List<Movie>? movies;

  MovieData({this.genres, this.movies});

  MovieData.fromJson(Map<String, dynamic> json) {
    genres = json['genres'].cast<String>();
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genres'] = this.genres;
    final movies = this.movies;
    if (movies != null) {
      data['movies'] = movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


