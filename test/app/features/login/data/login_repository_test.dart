import 'package:flutter_template/app/shared/core/result/result.dart';
import 'package:flutter_template/app/shared/data/data_sources/authentication_data_source.dart';
import 'package:flutter_template/app/shared/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([AuthenticationDataSource])
void main() {
  late MockAuthenticationDataSource mockDataSource;
  late AuthenticationRepository authenticationRepository;

  const testId = 'id';
  const testUsername = 'username';
  const testPassword = 'pwd1234!';

  setUp(() {
    mockDataSource = MockAuthenticationDataSource();
    authenticationRepository =
        AuthenticationRepositoryImpl(dataSource: mockDataSource);
  });

  group('Login UseCase', () {
    test('should call dataSource login method with required params', () async {
      // currently the datasource return a string not info about the user that should be returned not in string
      // but in the type of the api generate with the swagger
      when(mockDataSource.login(testId, testPassword))
          .thenAnswer((_) async => 'Success');
      final result = await authenticationRepository.login(testId, testPassword);

      expect(result, Success(const User(id: testId, username: testUsername)));
    });
  });
}
