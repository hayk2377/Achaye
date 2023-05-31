import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:achaye/account/account.dart';
import 'package:test/test.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  var random = Random().nextInt(10000);
  String ip = "192.168.187.46"; //for real device
  // String ip = "10.0. 2.2"; //for android emulator

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //run this from achaye/
  var dp = AccountDataProvider(
      baseUrl: "http://$ip:3001/api", headerProvider: HeaderProvider());

  var rp = AccountRepository(dp);
  String? imagePath = null;

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

  test("server connection works", () async {
    var testUrl = '${dp.baseUrl}/hi';
    await http.get(Uri.parse(testUrl));
  });

  group('basic account actions', () {
    test('signup has same email', () async {
      var returnedUser = await rp.signup(user);
      expect(returnedUser.email, user.email);
    });

    test('login brings works', () async {
      var result = await rp.login(user.email, user.password);
      expect(result, true);
    });
    test('edit should work', () async {
      var userMap = user.toMap();
      userMap["_id"] = "avbc";
      User userCopy = User.fromMap(userMap);
      userCopy.bio = "new bio";
      User returnedUser = await rp.edit(userCopy);
      expect(returnedUser.bio, userCopy.bio);
    });

    test('delete should be successful', () async {
      expect(await rp.delete(), true);
    });
    return;
  });
}
