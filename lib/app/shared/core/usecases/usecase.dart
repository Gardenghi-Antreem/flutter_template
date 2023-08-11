import 'package:equatable/equatable.dart';
import 'package:flutter_template/app/shared/core/error/failures/failures.dart';
import 'package:flutter_template/app/shared/core/result/result.dart';

abstract class UseCase<ReturnType, Params> {
  const UseCase();

  AsyncResult<ReturnType> call(Params params);
}

abstract class SyncUseCase<ReturnType, Params> {
  const SyncUseCase();

  Result<ReturnType, Failure> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
