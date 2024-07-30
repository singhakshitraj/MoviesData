import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Models/Movies.dart' as Movies;
import 'package:moviedb/Models/People.dart' as People;
import 'package:moviedb/Models/tvSeries.dart' as tvSeries;
import 'package:moviedb/Models/MovieDetails.dart';
import 'package:moviedb/Models/tvSeriesDetails.dart' as tvSeriesDetails;
import 'package:moviedb/Models/MovieReviews.dart' as MovieReviews;
import 'package:moviedb/Models/ImageUrls.dart';
import 'package:moviedb/Models/Movies.dart' as mov;

class ServerCalls {
  Future<List<Movies.Results>> getMoviesData(String category) async {
    List<Movies.Results> lis = [];
    String stringToParse =
        '${Endpoints.baseTrending}$category/day${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    if (response.statusCode == 200) {
      print('Success');
      final data = jsonDecode(response.body)['results'];
      for (Map val in data) {
        lis.add(Movies.Results.fromJson(val));
      }
    }
    return lis;
  }

  Future<List<People.Results>> getPeopleData(String category) async {
    List<People.Results> lis = [];
    String stringToParse =
        '${Endpoints.baseTrending}person/week${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    if (response.statusCode == 200) {
      print('Success');
      final data = jsonDecode(response.body)['results'];
      for (Map val in data) {
        lis.add(People.Results.fromJson(val));
      }
    } else {
      print("Error");
    }
    return lis;
  }

  Future<List<tvSeries.Results>> getSeriesData(String category) async {
    List<tvSeries.Results> lis = [];
    final response = await http
        .get(Uri.parse('${Endpoints.baseUrl}/tv/$category${Endpoints.apiKey}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'];
      for (Map val in data) {
        lis.add(tvSeries.Results.fromJson(val));
      }
    } else {
      print('Error');
    }
    return lis;
  }

  Future getMovieDetails(String id) async {
    final Response = await http
        .get(Uri.parse('${Endpoints.baseUrl}/movie/$id${Endpoints.apiKey}'));
    final data = jsonDecode(Response.body.toString());
    return MovieDetails.fromJson(data);
  }

  Future<List<Movies.Results>> getMoviesAdditionalData(
      String id, String additionalItem) async {
    List<Movies.Results> lis = [];
    String stringToParse =
        '${Endpoints.baseUrl}/movie/$id/$additionalItem${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    if (response.statusCode == 200) {
      print('Successfully Hit');
      final data = jsonDecode(response.body)['results'];
      for (Map val in data) {
        lis.add(Movies.Results.fromJson(val));
      }
    } else {
      print('Not Hit');
    }
    return lis;
  }

  Future getTvSeriesDetails(String id) async {
    String toParse = '${Endpoints.baseUrl}/tv/$id${Endpoints.apiKey}';
    final Response = await http.get(Uri.parse(toParse));
    final data = jsonDecode(Response.body.toString());
    return tvSeriesDetails.TvSeriesDetails.fromJson(data);
  }

  Future<List<MovieReviews.Results>> getMovieReviews(String id) async {
    List<MovieReviews.Results> lis = [];
    String stringToParse =
        '${Endpoints.baseUrl}/movie/$id/reviews${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'];
      for (Map vals in data) {
        lis.add(MovieReviews.Results.fromJson(vals));
      }
    }
    return lis;
  }

  Future<List<String>> getImageUrls(String id, String additionalData) async {
    List<String> lis = [];
    String stringToParse =
        '${Endpoints.baseUrl}/$additionalData/$id/images${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['backdrops'];
      for (Map val in data) {
        lis.add(Endpoints.baseImgOriginal +
            Backdrops.fromJson(val).filePath.toString());
      }
    }
    return lis;
  }

  Future<List<tvSeries.Results>> getTvSeriesAdditional(
      String id, String additional) async {
    List<tvSeries.Results> lis = [];
    String stringToParse =
        '${Endpoints.baseUrl}/tv/$id/$additional${Endpoints.apiKey}';
    final response = await http.get(Uri.parse(stringToParse));
    final data = jsonDecode(response.body)['results'];
    for (Map value in data) {
      lis.add(tvSeries.Results.fromJson(value));
    }
    return lis;
  }

  Future<List<mov.Results>> getSearchResults(String query) async {
    List<mov.Results> lis = [];
    final stringToParse =
        '${Endpoints.baseUrl}/search/multi${Endpoints.apiKey}&query=$query';
    final response = await http.get(Uri.parse(stringToParse));
    final data = jsonDecode(response.body)['results'];
    for (Map value in data) {
      if (Movies.Results.fromJson(value).mediaType != 'person') {
        lis.add(Movies.Results.fromJson(value));
      }
    }
    return lis;
  }
}
