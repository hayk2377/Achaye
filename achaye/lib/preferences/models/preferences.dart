import 'package:equatable/equatable.dart';

class Preferences extends Equatable {
  String photoUrl;
  List<String> religiousPreferences;
  List<String> hobbies;

  Preferences(
      {required this.photoUrl,
      required this.religiousPreferences,
      required this.hobbies});

  Preferences.fromJson(Map<String, Object> json)
      : photoUrl = json["photoUrl"] as String,
        religiousPreferences = json["religiousPreferences"] as List<String>,
        hobbies = json["hobbies"] as List<String>;

  Map<String, Object> toJson() {
    Map<String, Object> json = {
      "photoUrl": photoUrl,
      "religiousPreferences": religiousPreferences,
      "hobbies": hobbies
    };
    return json;
  }

  @override
  List<Object?> get props => [photoUrl, ...religiousPreferences, ...hobbies];
}
