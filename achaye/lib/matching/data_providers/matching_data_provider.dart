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

  Future<http.Response> getMatches() async {
    var response = await http.get(Uri.parse('$baseUrl/matches'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> createAppointment(
      String chatId, String appointment) async {
    var response = await http.post(
        Uri.parse(
          '$baseUrl/appointments/$chatId/',
        ),
        body: jsonEncode({"appointment": appointment}));
    return response;
  }

  Future<http.Response> deleteAppointment(
      String chatId, String appointment) async {
    var response =
        await http.delete(Uri.parse('$baseUrl/appointments/$chatId'));
    return response;
  }

  Future<http.Response> editAppointment(
      String chatId, String appointment) async {
    var response = await http.put(Uri.parse('$baseUrl/appointments/$chatId/'),
        body: jsonEncode({"appointment": appointment}));
    return response;
  }

  //get
}
