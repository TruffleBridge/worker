import 'package:dartz/dartz.dart';
import 'package:nimora_worker/core/utils/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
