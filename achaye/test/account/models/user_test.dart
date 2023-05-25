import 'package:achaye/account/models/user.dart';
import 'package:test/test.dart';

void main() {
  var user = User(
      email: "abc@gmail.com",
      password: "abc",
      firstName: "abc",
      lastName: "def",
      sex: "male",
      religion: "abc",
      birthday: "8/8/2008",
      bio: "something",
      photoUrl: "https://image.jpg",
      religiousPreferences: const ["abc", "cde"],
      hobbies: const ["abc", "cde"]);

  test('should have name', () {
    expect(user.firstName, "abc");
  });

  test('toJson() should have the same  name', () {
    var json = user.toJson();
    print(json);
    expect(user.firstName, json["firstName"]);
  });

  test('from Json should have the same name', () {
    var sameUser = User.fromJson(const {
      "firstName": "abc",
      "email": "",
      "password": "",
      "lastName": "",
      "sex": "",
      "religion": "",
      "birthday": "",
      "bio": "",
      "photoUrl": "",
      "religiousPreferences": <String>["abc", "def"],
      "hobbies": <String>["hij", "klm"]
    });
    expect(user.firstName, sameUser.firstName);
  });

  test('toJson should have the same hobbies', () {
    var json = user.toJson();
    expect(user.hobbies, json["hobbies"]);
  });

  test('toJson() -> fromJson() should have the same name ', () {
    var json = user.toJson();
    var sameUser = User.fromJson(json);
    expect(user.firstName, sameUser.firstName);
  });

  test('toJson() -> fromJson() should equal the same user ', () {
    var json = user.toJson();
    var sameUser = User.fromJson(json);
    expect(user, sameUser);
  });
}
