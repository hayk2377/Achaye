import 'dart:io';

import 'package:achaye/account/models/user.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  User user;

  user = User(
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

  test('toMap() should have the same  name', () {
    var json = user.toMap();
    expect(user.firstName, json["firstName"]);
  });

  test('from Json should have the same name', () {
    var sameUser = User.fromMap(const {
      "_id": "abc",
      "firstName": "abc",
      "email": "",
      "password": "",
      "lastName": "",
      "sex": "",
      "religion": "",
      "birthday": "",
      "bio": "",
      "religiousPreferences": <String>["abc", "def"],
      "hobbies": <String>["hij", "klm"]
    });
    expect(user.firstName, sameUser.firstName);
  });

  test('should accept List<dynamic>', () {
    var sameUser = User.fromMap(const {
      "_id": "ada",
      "firstName": "abc",
      "email": "",
      "password": "",
      "lastName": "",
      "sex": "",
      "religion": "",
      "birthday": "",
      "bio": "",
      "photoUrl": "",
      "religiousPreferences": <dynamic>["abc", "def"],
      "hobbies": <dynamic>["hij", "klm"]
    });
    expect(user.firstName, sameUser.firstName);
  });

  test('toMap should have the same hobbies', () {
    var json = user.toMap();
    expect(user.hobbies, json["hobbies"]);
  });

  test('toMap() -> fromMap() should have the same name ', () {
    var json = user.toMap();
    json["_id"] = "adf";
    var sameUser = User.fromMap(json);
    expect(user.firstName, sameUser.firstName);
  });

  //run the file from achaye dir
}
