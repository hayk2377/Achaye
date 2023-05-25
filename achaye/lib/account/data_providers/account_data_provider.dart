import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AccountDataProvider {
  Dio dio;
  AccountDataProvider(this.dio);
  final baseUrl = "http://localhost:3000/api";

  Future<User> create(User user) async {
    var response = await http.post(Uri.parse('$baseUrl/users'),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()));
    if (response.statusCode != 200) throw Exception("Could not create accoutn");

    var json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<User> login(String email, String password) async {
    var response = await http.post(Uri.parse('$baseUrl/users/logged-in'),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode != 200) throw Exception("bad status code");
    var json = jsonDecode(response.body);
    if (json.contains("error")) throw Exception(json["error"]);

    return User.fromJson(json);
  }

  void logout() async {
    var response = await http.delete(Uri.parse('$baseUrl/users/logged-in'));
    if (response.statusCode != 200) throw Exception("bad status code");
    var json = jsonDecode(response.body);
    if (json.contains("error")) throw Exception(json["error"]);
  }

  Future<User> update(User user) async {
    var response = await http.put(Uri.parse('$baseUrl/profile'),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()));
    if (response.statusCode != 200) throw Exception("Could not update profile");

    var json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  void delete() async {
    var response = await http.delete(Uri.parse('$baseUrl/'));
    var json = jsonDecode(response.body);

    if (json.contains("error")) throw Exception(json["error"]);
  }
}
