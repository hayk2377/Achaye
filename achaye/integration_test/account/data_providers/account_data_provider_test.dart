import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:achaye/account/account.dart';
import 'package:test/test.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  var random = Random().nextInt(10000);
  String ip = "192.168.187.46"; //for real device
  // String ip = "10.0. 2.2"; //for android emulator

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //run this from achaye/
  var dp = AccountDataProvider(
      baseUrl: "http://$ip:3001/api", headerProvider: HeaderProvider());

  // var imagePath = '/assets/dummy.jpeg';
  var imagePath = null;

  var user = User(
    email: "abc$random@abcemal.com",
    password: "abc",
    firstName: "abc",
    lastName: "abc",
    sex: "male",
    religion: "abc",
    birthday: "0123",
    bio: "abc bio",
    religiousPreferences: ["abc"],
    hobbies: ["abc", "cde"],
    imageFilePath: imagePath,
  );

  test('provider has base url', () {
    expect(dp.baseUrl, isNotNull);
  });

  test("server connection works", () async {
    var testUrl = '${dp.baseUrl}/hi';
    await http.get(Uri.parse(testUrl));
  });

  group('basic account actions', () {
    test('create has no error', () async {
      var response = await dp.create(user.toMap());
      User.fromMap(response.data);
    });
    test('login brings token', () async {
      http.Response res = await dp.login(user.email, user.password);
      var json = jsonDecode(res.body);
      String accessToken = json["accessToken"];

      await HeaderProvider().storeToken(accessToken);
      expect(5, isNotNull);
    });

    test('should be able to update bio', () async {
      User userCopy = User.fromMap(user.toMap());
      userCopy.bio = "new bio";
      var res = await dp.update(userCopy.toMap());
      var json = jsonDecode(res.body);
      User returnedUser = User.fromMap(json);
      expect(returnedUser.bio, userCopy.bio);
    });

    test('delete should be successful', () async {
      var res = await dp.delete();
      var json = jsonDecode(res.body);
      expect(json["isDeleted"], true);
    });
  });
}
