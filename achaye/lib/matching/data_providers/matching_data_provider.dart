import 'dart:convert';
import 'package:achaye/utils/json_header.dart';
import 'package:http/http.dart' as http;

class MatchingDataProvider {
  final String baseUrl;
  HeaderProvider headerProvider;
  MatchingDataProvider({required this.baseUrl, required this.headerProvider});

  Future<http.Response> getSuggestions() async {
    var response = await http.get(Uri.parse('$baseUrl/suggestions'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> like(String likedId) async {
    var response = await http.post(
      Uri.parse('$baseUrl/likes'),
      headers: await headerProvider.create(),
      body: jsonEncode({"userId": likedId}),
    );

    return response;
  }

  Future<http.Response> dislike(String dislikedId) async {
    var response = await http.post(
      Uri.parse('$baseUrl/likes'),
      headers: await headerProvider.create(),
      body: jsonEncode({"userId": dislikedId}),
    );

    return response;
  }
}