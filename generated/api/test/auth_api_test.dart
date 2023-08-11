import 'package:test/test.dart';
import 'package:flutter_template_api/flutter_template_api.dart';


/// tests for AuthApi
void main() {
  final instance = FlutterTemplateApi().getAuthApi();

  group(AuthApi, () {
    //Future<String> v2AuthLoginPost({ UserCredentials userCredentials }) async
    test('test v2AuthLoginPost', () async {
      // TODO
    });

  });
}
