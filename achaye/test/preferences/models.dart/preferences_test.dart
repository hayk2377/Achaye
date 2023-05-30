import 'package:achaye/preferences/models/preferences.dart';
import 'package:test/test.dart';

void main() {
  var preferences = Preferences(
      photoUrl: "https://image.jpg",
      religiousPreferences: const ["abc", "def"],
      hobbies: const ["ave", "def"]);
  test("photUrl should be the same", () {
    expect(preferences.photoUrl, "https://image.jpg");
  });

  test("toJson() should have photUrl", () {
    var json = preferences.toJson();
    expect(preferences.photoUrl, json["photoUrl"]);
  });

  test("toJson() fromJson() should equal original message", () {
    var json = preferences.toJson();
    var samePreferences = Preferences.fromJson(json);
    expect(preferences, samePreferences);
  });
}
