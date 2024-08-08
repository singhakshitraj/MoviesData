import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Models/Movies.dart' as movies;
import 'package:moviedb/Models/tvSeries.dart' as tv_series;
import 'package:shared_preferences/shared_preferences.dart';

class AddToList {
  Future<String> addToLiked(String mediaType, String mediaId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final value = sharedPreferences.getString('sessionID');
    final response = await http.post(
        Uri.parse(
            '${Endpoints.baseUrl}/account/$value/favorite${Endpoints.apiKey}&session_id=$value'),
        body: {
          "media_type": mediaType,
          "media_id": mediaId,
          "favorite": "true"
        });
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['success'];
      return data.toString();
    } else {
      return '-1';
    }
  }

  Future<String> addToWatchlist(String mediaType, String mediaId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final sessionID = sharedPreferences.getString('sessionID');
    final response = await http.post(
        Uri.parse(
            '${Endpoints.baseUrl}/account/$sessionID/watchlist${Endpoints.apiKey}&session_id=$sessionID'),
        body: {
          "media_type": mediaType,
          "media_id": mediaId,
          "watchlist": "true"
        });
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['success'];
      return data.toString();
    } else {
      return '-1';
    }
  }
}

class ShowList {
  Future<List<movies.Results>> getMovieList(String whatToSearch) async {
    List<movies.Results> lis = [];
    final sharedPreferences = await SharedPreferences.getInstance();
    final accountID = sharedPreferences.getString('accountID');
    final sessionID = sharedPreferences.getString('sessionID');
    final response = await http.get(Uri.parse(
        '${Endpoints.baseUrl}/account/${accountID!}/$whatToSearch/movies${Endpoints.apiKey}&session_id=${sessionID!}'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)['results'];
      for (Map value in data) {
        lis.add(movies.Results.fromJson(value));
      }
    } else {
      print('GetMovieList --> ${response.body}');
    }
    return lis;
  }

  Future<List<tv_series.Results>> getTvSeriesList(String whatToSearch) async {
    List<tv_series.Results> lis = [];
    final sharedPreferences = await SharedPreferences.getInstance();
    final accountID = sharedPreferences.getString('accountID');
    final sessionID = sharedPreferences.getString('sessionID');
    final response = await http.get(Uri.parse(
        '${Endpoints.baseUrl}/account/${accountID!}/$whatToSearch/tv${Endpoints.apiKey}&session_id=${sessionID!}'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)['results'];
      for (Map value in data) {
        lis.add(tv_series.Results.fromJson(value));
      }
    } else {
      print('GetTvSeriesList --> ${response.body}');
    }
    return lis;
  }
}
