import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb/API/endpoints.dart';
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
    final value = sharedPreferences.getString('sessionID');
    final response = await http.post(
        Uri.parse(
            '${Endpoints.baseUrl}/account/$value/watchlist${Endpoints.apiKey}&session_id=$value'),
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
