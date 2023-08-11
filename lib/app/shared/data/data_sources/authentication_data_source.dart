import 'package:flutter_template/app/shared/core/api/api_manager.dart';
import 'package:flutter_template/app/shared/data/utils/response_manager.dart';
import 'package:flutter_template_api/flutter_template_api.dart';

class AuthenticationDataSource {
  AuthenticationDataSource({required this.apiManager});

  final ApiManager apiManager;

  Future<String> login(String id, String password) {
    final userCredentials = UserCredentialsBuilder()
      ..id = id
      ..password = password;
    return apiManager.authUserApi
        .v2AuthLoginPost(userCredentials: userCredentials.build())
        .then(getResponseData);
  }
}
