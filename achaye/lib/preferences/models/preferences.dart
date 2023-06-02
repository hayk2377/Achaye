import 'package:equatable/equatable.dart';

class Preferences extends Equatable {
  List<String> religiousPreferences;
  List<String> hobbies;

  Preferences({required this.religiousPreferences, required this.hobbies});

  Preferences.fromMap(Map<String, dynamic> json)
      : religiousPreferences = List<String>.from(json["religiousPreferences"]),
        hobbies = List<String>.from(json["hobbies"]);

  Map<String, Object> toMap() {
    Map<String, Object> json = {
      "religiousPreferences": religiousPreferences,
      "hobbies": hobbies
    };
    return json;
  }

  @override
  List<Object?> get props => [...religiousPreferences, ...hobbies];
}
