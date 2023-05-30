import 'package:equatable/equatable.dart';
import 'dart:io';
import 'dart:convert';

class User extends Equatable {
  String email;
  String password;
  String firstName;
  String lastName;

  String sex;
  String religion;
  String birthday;
  String bio;

  String? photoUrl;
  String? imageFilePath;

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
    this.photoUrl,
    this.imageFilePath,
    required this.religiousPreferences,
    required this.hobbies,
  });

  User.fromMap(Map<String, dynamic> map)
      : email = map["email"] as String,
        password = map["password"] as String,
        firstName = map["firstName"] as String,
        lastName = map["lastName"] as String,
        sex = map["sex"] as String,
        religion = map["religion"] as String,
        birthday = map["birthday"] as String,
        bio = map["bio"] as String,
        photoUrl = map["photoUrl"],
        //should not accept imagePath from map
        religiousPreferences = List<String>.from(map["religiousPreferences"]),
        hobbies = List<String>.from(map["hobbies"]);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "sex": sex,
      "religion": religion,
      "birthday": birthday,
      "bio": bio,
      //no photoUrl, should not ever get modified
      "imageFilePath": imageFilePath,
      "religiousPreferences": religiousPreferences,
      "hobbies": hobbies,
    };
    return map;
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
        ...religiousPreferences,
        ...hobbies
      ];
}
