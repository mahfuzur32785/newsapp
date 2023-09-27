import 'package:dartz/dartz.dart';
import 'package:newsapp/core/data/datasources/local_data_source.dart';
import 'package:newsapp/core/data/datasources/remote_data_source.dart';
import 'package:newsapp/core/error/exceptions.dart';
import 'package:newsapp/core/error/failures.dart';

abstract class SplashRepository {
  Either<Failure, bool> checkOnBoarding();
  Future<Either<Failure, bool>> cacheOnBoarding();
}

class SplashRepositoryImp extends SplashRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  SplashRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      final result = localDataSource.checkOnBoarding();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheOnBoarding() async {
    try {
      return Right(await localDataSource.cacheOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
