import 'dart:async';
import 'dart:convert';
import 'package:credicxo_task/models/models.dart';
import 'package:credicxo_task/config/config.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  Future<List<MovieListItem>> getMovies() async {
    var response = await http.get(api1);
    var dataJson = jsonDecode(response.body);
    var list = dataJson['results'] as List;
    final List<MovieListItem> result = list.map((item) {
      return new MovieListItem(
          name: item['title'],
          imgPath: item['poster_path'],
          movieId: item['id'].toString());
    }).toList();
    return result;
  }

  Future<MovieDetails> getMovieDetails(String movieId) async {
    final String url = api2.replaceAll('MOVIEID', movieId);
    final String creditsUrl = creditsApi.replaceAll('MOVIEID', movieId);
    var response = await http.get(url);
    var creditsReponse = await http.get(Uri.parse(creditsUrl));
    final dataJson = jsonDecode(response.body);
    final creditsJson = jsonDecode(creditsReponse.body);
    var creditsList = creditsJson['cast'] as List;
    List<Cast> cast = creditsList.map((item) {
      return Cast(
          imagePath: item['profile_path'],
          name: item['name'],
          stageName: item['character']);
    }).toList();
    var result = new MovieDetails().fromJson(dataJson);
    result.copyWith(cast: cast);
    return result;
  }

  Future<List<MovieListItem>> search(String movieName) async {
    final String url = searchUrl.replaceAll('QUERY', movieName);
    var response = await http.get(Uri.parse(url));
    final dataJson = jsonDecode(response.body);
    var list = dataJson['results'] as List;
    final List<MovieListItem> results = list.map((item) {
      return MovieListItem(
          name: item['title'],
          movieId: item['id'].toString(),
          imgPath: item['poster_path'] ?? '');
    }).toList();
    return results;
  }
}
