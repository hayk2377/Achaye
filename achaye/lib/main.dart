import 'package:achaye/app.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:flutter/material.dart';

//repo providers
import 'package:achaye/account/account.dart';
import 'package:achaye/matching/matching.dart';
import 'package:achaye/preferences/preferences.dart';
//

void main() {
  var baseUrl = "http://192.168.189.46:3001/api";
  var headerProvider = HeaderProvider();

  var accountDataProvider =
      AccountDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);

  var matchingDataProvider =
      MatchingDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);

  var preferencesDataProvider =
      PreferencesDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);
  runApp(AchayeApp(
    accountDataProvider: accountDataProvider,
    matchingDataProvider: matchingDataProvider,
    preferencesDataProvider: preferencesDataProvider,
  ));
}
