import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:achaye/account/account.dart';
import 'package:test/test.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  String ip = "192.168.45.46"; //for real device
  // String ip = "10.0. 2.2"; //for android emulator

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //
  var dp = AccountDataProvider(
      baseUrl: "http://$ip:3001/api", headerProvider: HeaderProvider());

  var random = Random().nextInt(10000);
  var user = User(
      email: "abc$random@abcemal.com",
      password: "abc",
      firstName: "abc",
      lastName: "abc",
      sex: "male",
      religion: "abc",
      birthday: "0123",
      bio: "abc bio",
      photoUrl: "abc.jpg",
      religiousPreferences: const ["abc"],
      hobbies: const ["abc", "cde"]);

  test('provider has base url', () {
    expect(dp.baseUrl, isNotNull);
  });

  test("server connection works", () async {
    var testUrl = '${dp.baseUrl}/hi';
    await http.get(Uri.parse(testUrl));
  });

  group('basic account actions', () {
    test('create has no error', () async {
      print(dp.baseUrl);
      var res = await dp.create(user.toJson());
      var json = jsonDecode(res.body);
      User.fromJson(json);
    });

    test('login brings token', () async {
      http.Response res = await dp.login(user.email, user.password);
      var json = jsonDecode(res.body);
      String accessToken = json["accessToken"];

      await HeaderProvider().storeToken(accessToken);
      expect(5, isNotNull);
    });

    test('should be able to update bio', () async {
      User userCopy = User.fromJson(user.toJson());
      userCopy.bio = "new bio";
      var res = await dp.update(userCopy.toJson());
      var json = jsonDecode(res.body);
      print(json);
      User returnedUser = User.fromJson(json);
      expect(returnedUser.bio, userCopy.bio);
    });
  });
}
