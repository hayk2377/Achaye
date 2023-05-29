import 'package:shared_preferences/shared_preferences.dart';

class HeaderProvider {
  Future<Map<String, String>> create({bool withToken = false}) async {
    Map<String, String> header = {
      'Content-Type': 'application/json;',
    };

    if (withToken) {
      String accessToken = await getStoredToken();
      header['Authorization'] = 'Bearer $accessToken';
    }
    return header;
  }

  Future<String> getStoredToken() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    if (accessToken == null) {
      throw Exception("No Jwt access token!");
    } else {
      return accessToken as String;
    }
  }

  Future<void> storeToken(String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", accessToken);
  }
}