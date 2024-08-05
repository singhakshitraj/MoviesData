import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb/API/endpoints.dart';

class Auth {
  Future<String> requestToken() async {
    final response = await http
        .get(Uri.parse("${Endpoints.authSession}token/new${Endpoints.apiKey}"));
    if (response.statusCode == 200) {
      final tokenId = jsonDecode(response.body)['request_token'] as String;
      return tokenId;
    } else {
      return '';
    }
  }

  Future<String> createSession(String token) async {
    final response = await http.post(
        Uri.parse('${Endpoints.authSession}session/new${Endpoints.apiKey}'),
        body: {"request_token": token});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return data['session_id'];
      } else {
        return '-1';
      }
    } else {
      return '-1';
    }
  }
}
