import '../models/preferences.dart';
import '../data_providers/preferences_data_provider.dart';
import 'dart:convert';

class PreferencesRepository {
  PreferencesDataProvider preferencesDataProvider;
  PreferencesRepository(this.preferencesDataProvider);

  Future<Preferences> get() async {
    var response = await preferencesDataProvider.get();
    Preferences preferences = Preferences.fromJson(jsonDecode(response.body));
    return preferences;
  }

  Future<Preferences> create(Preferences newPreferences) async {
    var response =
        await preferencesDataProvider.update(newPreferences.toJson());
    return Preferences.fromJson(jsonDecode(response.body));
  }

  Future<Preferences> update(Preferences updatedPreferences) async {
    var response =
        await preferencesDataProvider.update(updatedPreferences.toJson());
    return Preferences.fromJson(jsonDecode(response.body));
  }

  Future<bool> delete() async {
    var response = await preferencesDataProvider.delete();
    return response.statusCode == 200;
  }
}
