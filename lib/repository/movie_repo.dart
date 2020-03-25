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

  Future<String> getMovieDetails(String movieId) async {
    final String url = api2.replaceAll('MOVIEID', movieId);
    var response = await http.get(url);
    final result = jsonDecode(response.body);
    return result[''];
  }
}
