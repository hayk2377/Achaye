import 'dart:convert';
import 'package:achaye/utils/json_header.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class AccountDataProvider {
  final String baseUrl;
  HeaderProvider headerProvider;
  AccountDataProvider({required this.baseUrl, required this.headerProvider});

  Future<Response> create(Map<String, dynamic> userMap) async {
    final dio = Dio();

    if (userMap["imageFilePath"] != null) {
      var filePath = userMap["imageFilePath"] as String;
      var file = await MultipartFile.fromFile(filePath);
      userMap["file"] = file;
    }

    final formData = FormData.fromMap(userMap);
    var response = await dio.post('$baseUrl/users', data: formData);

    return response;
  }

  Future<http.Response> login(String email, String password) async {
    var response = await http.post(
      Uri.parse('$baseUrl/users/logged-in'),
      headers: await headerProvider.create(withToken: false),
      body: jsonEncode({"email": email, "password": password}),
    );

    return response;
  }

  // Future<http.Response> logOut() async {
  //   var response = await http.delete(
  //       //
  //       Uri.parse('$baseUrl/users/logged-in'),
  //       headers: await headerProvider.create());

  //   return response;
  // }

  Future<http.Response> update(Map<String, dynamic> profileJson) async {
    var response = await http.put(Uri.parse('$baseUrl/profile'),
        headers: await headerProvider.create(), body: jsonEncode(profileJson));

    return response;
  }

  Future<http.Response> delete() async {
    var response = await http.delete(Uri.parse('$baseUrl/'),
        headers: await headerProvider.create());
    return response;
  }
}
