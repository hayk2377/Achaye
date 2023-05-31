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
    hobbies: const ["abc", "cde"],
    photoUrl: "https://image.jpg",
  );

  test('should have name', () {
    expect(otherUser.firstName, "abc");
  });

  test('toMap() should have the same  name', () {
    var json = otherUser.toMap();
    expect(otherUser.firstName, json["firstName"]);
  });

  test('from Json should have the same name', () {
    var sameUser = OtherUser.fromMap(<String, dynamic>{
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

  test('toMap should have the same hobbies', () {
    var json = otherUser.toMap();
    expect(otherUser.hobbies, json["hobbies"]);
  });

  test('toMap() -> fromMap() should have the same name ', () {
    var json = otherUser.toMap();
    var sameUser = OtherUser.fromMap(json);
    expect(otherUser.firstName, sameUser.firstName);
  });

  test('toMap() -> fromMap() should equal the same user ', () {
    var json = otherUser.toMap();
    var sameUser = OtherUser.fromMap(json);
    expect(otherUser, sameUser);
  });
}
