import 'dart:convert';
import 'package:moviedb/Models/tvSeries.dart' as tv_series;
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Models/Movies.dart' as mov;
import 'package:http/http.dart' as http;

class SearchResults {
  Future<List<mov.Results>> getMovieSearchResults(String query) async {
    List<mov.Results> lis = [];
    final stringToParse =
        '${Endpoints.baseUrl}/search/movie${Endpoints.apiKey}&query=$query';
    final response = await http.get(Uri.parse(stringToParse));
    final data = jsonDecode(response.body)['results'];
    for (Map value in data) {
      lis.add(mov.Results.fromJson(value));
    }
    return lis;
  }

  Future<List<tv_series.Results>> getTvSeriesSearchResults(String query) async {
    List<tv_series.Results> lis = [];
    final stringToParse =
        '${Endpoints.baseUrl}/search/tv${Endpoints.apiKey}&query=$query';
    final response = await http.get(Uri.parse(stringToParse));
    final data = jsonDecode(response.body)['results'];
    for (Map value in data) {
      lis.add(tv_series.Results.fromJson(value));
    }
    return lis;
  }
}
