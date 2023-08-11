import 'package:equatable/equatable.dart';
import 'package:flutter_template/app/shared/core/error/exceptions.dart';
import 'package:flutter_template/app/shared/core/error/failures/api_failures.dart';
import 'package:flutter_template/l10n/app_translations.dart';

abstract class Failure extends Equatable {
  const Failure();

  factory Failure.fromException(Exception exception) {
    if (exception is ApiException) {
      return ApiFailure(
        statusCode: exception.statusCode,
        errorMessage: exception.errorMessage,
      );
    } else if (exception is ServerException) {
      return ServerFailure();
    }
    return UnknownFailure();
  }

  @override
  List<Object> get props => [];

  String message();
}

// General failures
class ServerFailure extends Failure {
  @override
  String message() => tr.commonErrorServerFailureMessage;
}

class UnknownFailure extends Failure {
  @override
  String message() => tr.commonErrorUnknownFailureMessage;
}
