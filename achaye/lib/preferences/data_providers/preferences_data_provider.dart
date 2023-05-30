import 'dart:convert';
import 'package:achaye/utils/json_header.dart';
import 'package:http/http.dart' as http;

class PreferencesDataProvider {
  final String baseUrl;
  HeaderProvider headerProvider;
  PreferencesDataProvider(
      {required this.baseUrl, required this.headerProvider});

  Future<http.Response> get() async {
    var response = await http.get(Uri.parse('$baseUrl/profile'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> create(Map<String, Object> updatedPreferences) async {
    var response = await http.post(
      Uri.parse('$baseUrl/profile'),
      headers: await headerProvider.create(),
      body: jsonEncode(updatedPreferences),
    );
    return response;
  }

  Future<http.Response> update(Map<String, Object> updatedPreferences) async {
    var response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: await headerProvider.create(),
      body: jsonEncode(updatedPreferences),
    );
    return response;
  }

  Future<http.Response> delete() async {
    var response = await http.delete(
      Uri.parse('$baseUrl/profile'),
      headers: await headerProvider.create(),
    );
    return response;
  }
}
