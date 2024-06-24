import 'package:dartz/dartz.dart';
import 'package:task_news_app/core/error/failure.dart';
import '../../../../core/classes/network_info.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/news_local_data_source.dart';
import '../data_sources/news_remote_data_source.dart';
import '../models/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkIChecker networkInfo;  // To check network connectivity

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles() async {
    if (await networkInfo.isConnected) {
      // If device is connected to the internet, try fetching from remote data source
      final remoteResult = await remoteDataSource.getNewsArticles();
      return remoteResult.fold(
            (failure) async {
          // If fetching from remote data source fails, try fetching from local cache
          final localResult = await localDataSource.getNewsArticlesFromCache();
          return localResult.fold(
                (localFailure) => Left(localFailure),
                (localArticles) => Right(localArticles),
          );
        },
            (remoteArticles) async {
          // If fetching from remote data source is successful, cache the data locally
          await localDataSource.cacheNewsArticles(remoteArticles);
          return Right(remoteArticles);
        },
      );
    } else {
      // If device is not connected to the internet, fetch from local cache
      final localResult = await localDataSource.getNewsArticlesFromCache();
      return localResult.fold(
            (localFailure) => Left(localFailure),
            (localArticles) => Right(localArticles),
      );
    }
  }
}
