import 'dart:convert';
import 'package:achaye/account/data_providers/account_data_provider.dart';
import '../models/user.dart';
import 'package:achaye/utils/json_header.dart';

class AccountRepository {
  AccountDataProvider accountDataProvider;
  AccountRepository(this.accountDataProvider);

  Future<User> signup(User user) async {
    var response = await accountDataProvider.create(user.toMap());
    Map<String, dynamic> json = response.data;
    return User.fromMap(json);
  }

  Future<bool> login(String email, String password) async {
    var response = await accountDataProvider.login(email, password);
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json["error"] == null) {
      String accessToken = json["accessToken"];
      await HeaderProvider().storeToken(accessToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    return await accountDataProvider.isLoggedIn();
  }

  Future<bool> logOut() async {
    var response = await accountDataProvider.logOut();
    Map<String, dynamic> json = jsonDecode(response.body);
    return (json["error"] != null);
  }

  Future<User> edit(User user) async {
    var response = await accountDataProvider.update(user.toMap());
    Map<String, dynamic> json = jsonDecode(response.body);

    return User.fromMap(json);
  }

  Future<bool> delete() async {
    await accountDataProvider.delete();
    return true;
  }
}
