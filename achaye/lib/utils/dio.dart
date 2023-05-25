import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class ConfiguredDioProvider {
  static final Dio _dio = Dio();
  static var isConfigured = false;

  static Future _configureDio() async {
    if (isConfigured) return;

    var appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final cookieJar = PersistCookieJar(
      storage: FileStorage('$appDocPath/.cookies/'),
    );

    _dio.interceptors.add(CookieManager(cookieJar));
    isConfigured = true;
  }

  static Future<Dio> getDio() async {
    await _configureDio();
    return _dio;
  }
}
