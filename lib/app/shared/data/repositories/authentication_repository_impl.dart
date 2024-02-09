import 'package:flutter_template/app/shared/core/error/failures/failures.dart';
import 'package:flutter_template/app/shared/core/result/result.dart';
import 'package:flutter_template/app/shared/data/data_sources/authentication_data_source.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({required this.dataSource});

  final AuthenticationDataSource dataSource;

  @override
  AsyncResult<User> login(String username, String password) async {
    try {
      await dataSource.login(username, password);
      return Success(
        const User(
          id: 'id',
          username: 'username',
        ),
      );
    } on Exception catch (e) {
      return Error(Failure.fromException(e));
    } catch (exception) {
      return Error(UnknownFailure());
    }
  }
}
