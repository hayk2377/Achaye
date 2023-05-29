import 'package:achaye/matching/models/other_user.dart';
import 'package:test/test.dart';

void main() {
  var otherUser = OtherUser(
    id: "abc",
    firstName: "abc",
    lastName: "abc",
    //
    age: 20,
    sex: "female",
    religion: "abc",
    bio: "abc",
    //
    hobbies: ["abc", "cde"],
    photoUrl: "https://image.jpg",
  );

  test('should have name', () {
    expect(otherUser.firstName, "abc");
  });

  test('toJson() should have the same  name', () {
    var json = otherUser.toJson();
    expect(otherUser.firstName, json["firstName"]);
  });

  test('from Json should have the same name', () {
    var sameUser = OtherUser.fromJson(const {
      "id": "abc",
      "firstName": "abc",
      "lastName": "abc",
      "age": 20,
      "sex": "female",
      "religion": "abc",
      "bio": "abc",
      "hobbies": ["abc", "cde"],
      "photoUrl": "https://image.jpg",
    });
    expect(otherUser.firstName, sameUser.firstName);
  });

  test('toJson should have the same hobbies', () {
    var json = otherUser.toJson();
    expect(otherUser.hobbies, json["hobbies"]);
  });

  test('toJson() -> fromJson() should have the same name ', () {
    var json = otherUser.toJson();
    var sameUser = OtherUser.fromJson(json);
    expect(otherUser.firstName, sameUser.firstName);
  });

  test('toJson() -> fromJson() should equal the same user ', () {
    var json = otherUser.toJson();
    var sameUser = OtherUser.fromJson(json);
    expect(otherUser, sameUser);
  });
}
