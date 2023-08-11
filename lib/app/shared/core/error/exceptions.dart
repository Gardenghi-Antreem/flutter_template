class ApiException implements Exception {
  ApiException({required this.statusCode, this.errorMessage});

  final int? statusCode;
  final String? errorMessage;
}

class ServerException implements Exception {}

class UnknownException implements Exception {}
