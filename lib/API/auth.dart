import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb/API/endpoints.dart';

class Auth {
  Future<String> requestToken() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/authentication/token/new" +
            Endpoints.apiKey));
    if (response.statusCode == 200) {
      final tokenId = jsonDecode(response.body)['request_token'] as String;
      //print(tokenId);
      return tokenId;
    } else {
      print('Unsuccessful');
      return '';
    }
  }
}
