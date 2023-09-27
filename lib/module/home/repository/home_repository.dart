import 'package:dartz/dartz.dart';
import 'package:newsapp/core/data/datasources/remote_data_source.dart';
import 'package:newsapp/core/error/exceptions.dart';
import 'package:newsapp/core/error/failures.dart';
import 'package:newsapp/module/home/model/home_model.dart';


abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeData();
  // Future<Either<Failure, List<ProductModel>>> getSearchData();
}

class HomeRepositoryImp extends HomeRepository {
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      final result = await remoteDataSource.getHomeData();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, List<ProductModel>>> getSearchData() async {
  //   try {
  //     final result = await remoteDataSource.getSearchData();
  //     return right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }


}
