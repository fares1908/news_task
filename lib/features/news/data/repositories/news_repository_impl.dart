import 'package:dartz/dartz.dart';
import 'package:task_news_app/core/error/failure.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/news_local_data_source.dart';
import '../data_sources/news_remote_data_source.dart';
import '../models/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles() async {
    final remoteResult = await remoteDataSource.getNewsArticles();
    return remoteResult.fold(
          (failure) async {
        final localResult = await localDataSource.getNewsArticlesFromCache();
        return localResult.fold(
              (localFailure) => Left(localFailure),
              (localArticles) => Right(localArticles),
        );
      },
          (remoteArticles) async {
        await localDataSource.cacheNewsArticles(remoteArticles);
        return Right(remoteArticles);
      },
    );
  }
}
