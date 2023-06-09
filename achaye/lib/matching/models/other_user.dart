import 'package:equatable/equatable.dart';

class OtherUser extends Equatable {
  String id;
  String firstName;
  String lastName;

  int age;
  String sex;
  String religion;
  String bio;

  List<String> hobbies;
  String photoUrl =
      "https://images.unsplash.com/photo-1610509528015-e4c30d95a5cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8fDA%3D&w=1000&q=80";

  OtherUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    //
    required this.age,
    required this.sex,
    required this.religion,
    required this.bio,
    //
    required this.hobbies,
    required this.photoUrl,
  });

  OtherUser.fromMap(Map<String, dynamic> json)
      : id = json["id"] as String,
        firstName = json["firstName"] as String,
        lastName = json["lastName"] as String,
        //
        age = json["age"] as int,
        sex = json["sex"] as String,
        religion = json["religion"] as String,
        bio = json["bio"] as String,
        //
        // photoUrl = json["photoUrl"] as String,
        photoUrl =
            "https://images.unsplash.com/photo-1610509528015-e4c30d95a5cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
        hobbies = List<String>.from(json["hobbies"]);

  Map<String, Object> toMap() {
    Map<String, Object> json = {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      //
      "age": age,
      "sex": sex,
      "religion": religion,
      "bio": bio,
      //
      "photoUrl": photoUrl,
      "hobbies": hobbies,
    };
    return json;
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        //
        age,
        sex,
        religion,
        bio,
        //
        photoUrl,
        ...hobbies
      ];
}
