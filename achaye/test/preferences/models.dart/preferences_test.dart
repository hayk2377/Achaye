import 'package:achaye/preferences/models/preferences.dart';
import 'package:test/test.dart';

void main() {
  var preferences = Preferences(
      religiousPreferences: const ["abc", "def"],
      hobbies: const ["ave", "def"]);
  test("toMap() religious Preferences same", () {
    var map = preferences.toMap();
    expect(preferences.religiousPreferences, map["religiousPreferences"]);
  });

  test("toMap() fromMap() religious Preferences same", () {
    var map = preferences.toMap();
    var copy = Preferences.fromMap(map);
    expect(copy.religiousPreferences, map["religiousPreferences"]);
  });
}
