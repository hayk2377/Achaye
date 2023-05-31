import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:achaye/matching/matching.dart';
import 'package:test/test.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:integration_test/integration_test.dart';
import 'package:achaye/account/account.dart';

User makeOpposite() {
  var random = Random().nextInt(10000);

  var oppositeUser = User(
    email: "cdf$random@abcemal.com",
    password: "abc",
    firstName: "abc",
    lastName: "abc",
    sex: "female",
    religion: "abc",
    birthday: "0123",
    bio: "abc bio",
    religiousPreferences: ["abc"],
    hobbies: ["abc", "cde"],
  );

  return oppositeUser;
}

void main() {
  var random = Random().nextInt(10000);
  String ip = "192.168.187.46"; //for real device
  // String ip = "10.0. 2.2"; //for android emulator

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  String baseUrl = "http://$ip:3001/api";
  var dp =
      MatchingDataProvider(baseUrl: baseUrl, headerProvider: HeaderProvider());

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
  );

  var accountDp =
      AccountDataProvider(baseUrl: baseUrl, headerProvider: HeaderProvider());
  var accountRp = AccountRepository(accountDp);

  test("server connection works", () async {
    var testUrl = '${dp.baseUrl}/hi';
    await http.get(Uri.parse(testUrl));
  });

  test("user created and logged in", () async {
    HeaderProvider().storeToken("abc");
    await accountRp.signup(makeOpposite());
    await accountRp.signup(makeOpposite());
    user = await accountRp.signup(user); //replaces
    var loggedIn = await accountRp.login(user.email, user.password);
    expect(loggedIn, true);
  });

  group('swipe activity', () {
    return;

    test('suggestions give a list', () async {
      var response = await dp.getSuggestions();
      var suggestions = jsonDecode(response.body);
      expect(suggestions.length, isNotNull);
    });

    test('like successfully', () async {
      var resSuggestions = await dp.getSuggestions();
      var suggestions = jsonDecode(resSuggestions.body);

      var resLike = await dp.like(suggestions[0]["id"]);
      var resJson = jsonDecode(resLike.body);

      print(resJson);
      expect(resJson["liked"], true);
    });

    test('dislike successfully', () async {
      var resSuggestions = await dp.getSuggestions();
      var suggestions = jsonDecode(resSuggestions.body);

      var resLike = await dp.dislike(suggestions[0]["id"]);
      var resJson = jsonDecode(resLike.body);

      print(resJson);
      expect(resJson["liked"], true);
    });
  });

  group('after matching', () {
    test('match successfully', () async {
      var partner = await accountRp.signup(makeOpposite());
      await dp.like(partner.id as String);

      await accountRp.login(partner.email, partner.password);
      var result = await dp.like(user.id as String);

      var json = jsonDecode(result.body);
      print("----------------");
      print(json);

      expect(json["matched"], true);
      await accountRp.login(user.email, user.password);
    });

    test('get matches has length', () async {
      var res = await dp.getMatches();
      var json = jsonDecode(res.body);
      expect(json.length, isNotNull);
    });

    test('should crud appointment', () async {
      var res = await dp.getMatches();
      var matches = jsonDecode(res.body);
      var appointment = "/88/9/8";
      String chatId = matches[0]["chatId"];

      var createRes = await dp.createAppointment(chatId, appointment);
      var createJson = jsonDecode(createRes.body);
      print(createJson);
      expect(createJson["appointment"], appointment);

      var newAppointment = "abc";
      var editRes = await dp.editAppointment(chatId, newAppointment);
      var editJson = jsonDecode(editRes.body);
      expect(editJson["appointment"], newAppointment);

      var deleteRes = await dp.deleteAppointment(chatId, newAppointment);
      var deleteJson = jsonDecode(editRes.body);
      expect(deleteJson["appointment"], null);
    });
  });
}
