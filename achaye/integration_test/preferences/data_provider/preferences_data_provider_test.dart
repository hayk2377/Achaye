import 'dart:math';
import 'package:achaye/preferences/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:integration_test/integration_test.dart';
import 'package:achaye/account/account.dart';
import 'package:achaye/account/account.dart';

void main() {
  var random = Random().nextInt(10000);
  String ip = "192.168.50.46"; //for real device
  // String ip = "10.0. 2.2"; //for android emulator

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  String baseUrl = "http://$ip:3001/api";
  var dp = PreferencesDataProvider(
      baseUrl: baseUrl, headerProvider: HeaderProvider());

  var user = User(
    email: "abc$random@abcemal.com",
    password: "abc",
    firstName: "abc",
    lastName: "abc",
    sex: "male",
    religion: "abc",
    birthday: "0123",
    bio: "abc bio",
    religiousPreferences: [], //same as no preferences
    hobbies: [],
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
    user = await accountRp.signup(user); //replaces
    var loggedIn = await accountRp.login(user.email, user.password);
    expect(loggedIn, true);
  });

  //test each function
}
