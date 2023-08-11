import 'package:dio/dio.dart';
import 'package:flutter_template/app/shared/core/config/config.dart';
import 'package:flutter_template_api/flutter_template_api.dart';

const _apiTimeoutMilliseconds = Duration(seconds: 15);

class ApiManager {
  ApiManager({required Config config})
      : _api = FlutterTemplateApi(
          dio: Dio(
            BaseOptions(
              connectTimeout: _apiTimeoutMilliseconds,
              receiveTimeout: _apiTimeoutMilliseconds,
              sendTimeout: _apiTimeoutMilliseconds,
              baseUrl: config.baseUrl,
            ),
          ),
          interceptors: [_Interceptor()],
        ) {
    authUserApi = _api.getAuthApi();
  }

  final FlutterTemplateApi _api;
  late final AuthApi authUserApi;

  // ignore: avoid_setters_without_getters
  set token(String token) {
    _tokenStore.token = token;
  }

  void clearToken() {
    _tokenStore.token = null;
  }
}

class _Interceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _tokenStore.token?.replaceAll('\n', '').replaceAll('\r', '');
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    super.onRequest(options, handler);
  }
}

class _TokenStore {
  String? token;
}

final _tokenStore = _TokenStore();
