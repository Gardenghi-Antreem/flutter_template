import 'package:flutter_template/app/shared/core/result/result.dart';

abstract class AuthenticationRepository {
  AsyncResult<void> login(String username, String password);
}
