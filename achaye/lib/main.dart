import 'package:achaye/app.dart';
import 'package:achaye/utils/json_header.dart';
import 'package:flutter/material.dart';

//repo providers
import 'package:achaye/account/account.dart';
import 'package:achaye/matching/matching.dart';
import 'package:achaye/preferences/preferences.dart';
//

void main() {
  var baseUrl = "http://192.168.222.46:3010/api";
  var headerProvider = HeaderProvider();

  var accountDataProvider =
      AccountDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);

  // var accountRepository = AccountRepository(accountDataProvider);

  //
  var matchingDataProvider =
      MatchingDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);
  // var matchingRepository = MatchingRepository(matchingDataProvider);

  //

  var preferencesDataProvider =
      PreferencesDataProvider(baseUrl: baseUrl, headerProvider: headerProvider);
  // var preferencesRepository = PreferencesRepository(preferencesDataProvider);

  runApp(AchayeApp(
    accountDataProvider: accountDataProvider,
    matchingDataProvider: matchingDataProvider,
    preferencesDataProvider: preferencesDataProvider,
  ));
}
