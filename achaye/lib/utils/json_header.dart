import 'package:shared_preferences/shared_preferences.dart';

class HeaderProvider {
  Future<Map<String, String>> create({bool withToken = true}) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    if (withToken) {
      String accessToken = await getStoredToken();
      ///////////
      if (accessToken == "") throw Exception("there is not token!");
      header['Authorization'] = 'Bearer $accessToken';
    }
    return header;
  }

  Future<String> getStoredToken() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    if (accessToken == null) {
      return "";
    } else {
      return accessToken;
    }
  }

  Future<void> storeToken(String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", accessToken);
  }

  Future<void> deleteToken() async {
    await storeToken("");
  }
}
