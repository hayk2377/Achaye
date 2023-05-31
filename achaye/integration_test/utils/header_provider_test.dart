import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:achaye/utils/json_header.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Random().nextInt(10); //to start from here at hot restart
  test('without token should give a map that has content type', () async {
    HeaderProvider hp = HeaderProvider();
    var header = await hp.create(withToken: false);
    expect(header["Content-Type"], isNotNull);
  });

  group('tokens', () {
    HeaderProvider hp = HeaderProvider();

    test('storing should not error', () async {
      var header = await hp.storeToken("abc");
    });

    test('stored token should be found', () async {
      await hp.storeToken("abc");
      var token = await hp.getStoredToken();

      expect(token, "abc");
    });

    test('header with token should have token', () async {
      await hp.storeToken("abc");
      var header = await hp.create();
      var hasToken = (header['Authorization'] as String).contains("abc");
      expect(hasToken, true);
    });
  });
}
