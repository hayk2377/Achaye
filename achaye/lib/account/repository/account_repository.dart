import 'dart:convert';
import 'package:achaye/account/data_providers/account_data_provider.dart';
import '../models/user.dart';

class Repository {
  AccountDataProvider accountDataProvider;
  Repository(this.accountDataProvider);

  Future<User> signup(User user) async {
    var response = await accountDataProvider.create(user.toJson());
    Map<String, Object> json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<bool> login(String email, String password) async {
    var response = await accountDataProvider.login(email, password);
    Map<String, Object> json = jsonDecode(response.body);
    return (json["error"] != null);
  }

  Future<bool> logOut() async {
    var response = await accountDataProvider.logOut();
    Map<String, Object> json = jsonDecode(response.body);
    return (json["error"] != null);
  }

  Future<User> edit(User user) async {
    var response = await accountDataProvider.update(user.toJson());
    Map<String, Object> json = jsonDecode(response.body);

    return User.fromJson(json);
  }

  Future<bool> delete() async {
    await accountDataProvider.delete();
    return true;
  }
}
