import 'package:credicxo_task/models/models.dart';

class MovieDetails {
  final String name;
  final String imagePath;
  final bool isAdult;
  final List genres;
  final String language;
  final String rating;
  final String overview;
  final List<Cast> cast;
  final String releaseDate;

  MovieDetails(
      {this.name,
      this.cast,
      this.genres,
      this.imagePath,
      this.isAdult,
      this.language,
      this.releaseDate,
      this.overview,
      this.rating});

  MovieDetails fromJson(Map<String, dynamic> data) {
    return MovieDetails(
        isAdult: data['adult'],
        name: data['original_title'],
        imagePath: data['poster_path'],
        language: data['original_language'],
        overview: data['overview'],
        rating: data['vote_average'].toString(),
        releaseDate: data['release_date'],
        genres: data['genres'].map((item) {
          return item['name'];
        }).toList());
  }

  MovieDetails copyWith({List<Cast> cast, List<String> genres}) {
    return MovieDetails(cast: cast ?? this.cast, genres: genres ?? this.genres);
  }

  @override
  String toString() => 'Details : $name, $isAdult, $rating';
}

class Cast {
  final String name;
  final String stageName;
  final String imagePath;

  Cast({this.name, this.imagePath, this.stageName});
}
