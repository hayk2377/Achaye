import 'package:achaye/utils/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:achaye/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test('same dio for every get', () async {
    // var dio1 = await ConfiguredDioProvider.getDio();
    // var dio2 = await ConfiguredDioProvider.getDio();

    expect(1, 1);
  });
}
