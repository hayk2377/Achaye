import 'package:equatable/equatable.dart';

class User extends Equatable {
  String email;
  String password;
  String firstName;
  String lastName;

  String sex;
  String religion;
  String birthday;
  String bio;

  String photoUrl;
  List<String> religiousPreferences;
  List<String> hobbies;

  User({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.religion,
    required this.birthday,
    required this.bio,
    required this.photoUrl,
    required this.religiousPreferences,
    required this.hobbies,
  });

  User.fromJson(Map<String, Object> json)
      : email = json["email"] as String,
        password = json["password"] as String,
        firstName = json["firstName"] as String,
        lastName = json["lastName"] as String,
        sex = json["sex"] as String,
        religion = json["religion"] as String,
        birthday = json["birthday"] as String,
        bio = json["bio"] as String,
        photoUrl = json["photoUrl"] as String,
        religiousPreferences = json["religiousPreferences"] as List<String>,
        hobbies = json["hobbies"] as List<String>;

  Map<String, Object> toJson() {
    Map<String, Object> json = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "sex": sex,
      "religion": religion,
      "birthday": birthday,
      "bio": bio,
      "photoUrl": photoUrl,
      "religiousPreferences": religiousPreferences,
      "hobbies": hobbies,
    };
    return json;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        sex,
        religion,
        birthday,
        bio,
        photoUrl,
        ...religiousPreferences,
        ...hobbies
      ];
}
