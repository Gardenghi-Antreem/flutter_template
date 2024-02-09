import 'package:flutter_template/app/shared/core/result/result.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';

abstract class AuthenticationRepository {
  AsyncResult<User> login(String username, String password);
}
