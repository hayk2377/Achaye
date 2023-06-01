import 'dart:convert';
import 'dart:math';
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
  String ip = "192.168.10.46"; //for android emulato r

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  String baseUrl = "http://$ip:3001/api";
  var dp =
      MatchingDataProvider(baseUrl: baseUrl, headerProvider: HeaderProvider());
  var repo = MatchingRepository(dp);

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
    print(testUrl);
    await http.get(Uri.parse(testUrl));
  });

  test("user created and logged in", () async {
    await HeaderProvider().storeToken("abc");

    await accountRp.signup(makeOpposite()); //will be liked
    await accountRp.signup(makeOpposite()); //will be disliked
    user = await accountRp.signup(user); //replaces
    var loggedIn = await accountRp.login(user.email, user.password);
    expect(loggedIn, true);
  });

  group('swipe activity', () {
    test('suggestions give a list', () async {
      var suggestions = await repo.getSuggestions();
      expect(suggestions.length, isNotNull);
    });

    test('like successfully', () async {
      var suggestions = await repo.getSuggestions();
      var resLike = await repo.like(suggestions[0].id);

      expect(resLike, true);
    });

    test('dislike successfully', () async {
      var suggestions = await repo.getSuggestions();
      var resDislike = await repo.dislike(suggestions[0].id);
      expect(resDislike, true);
    });
  });

  group('chats', () {
    test('match successfully', () async {
      var partner = await accountRp.signup(makeOpposite());
      await repo.like(partner.id as String);

      await accountRp.login(partner.email, partner.password);
      await repo.like(user.id as String);
      await accountRp.login(user.email, user.password);
    });
    test('get matches has length', () async {
      var matches = await repo.getMatches();
      expect(matches.length, isNotNull);
    });

    test('chat id should not be null', () async {
      var matches = await repo.getMatches();
      String chatId = matches[0].chatId;
      expect(chatId, isNotNull);
    });

    test('create appointment should work', () async {
      String chatId = (await repo.getMatches())[0].chatId;

      var isSuccessful = await repo.createAppointment(chatId, "abc");
      expect(isSuccessful, true);
    });

    test('update appointment should work', () async {
      String chatId = (await repo.getMatches())[0].chatId;

      var isSuccessful = await repo.editAppointment(chatId, "cde");
      expect(isSuccessful, true);
    });

    test('delete appointment should work', () async {
      String chatId = (await repo.getMatches())[0].chatId;

      var isSuccessful = await repo.deleteAppointment(chatId, "abc");
      expect(isSuccessful, true);
    });

    test('web sockets should not error', () async {
      String chatId = (await repo.getMatches())[0].chatId;

      var send = repo.enterChat(
          chatId: chatId, onMessage: (String message) => print(message));
    });
  });
}
