import 'package:ace_flash/core/failure.dart';
import 'package:either_dart/either.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
