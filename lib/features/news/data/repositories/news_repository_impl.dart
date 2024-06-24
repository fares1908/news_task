import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:task_news_app/core/error/failure.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/news_remote_data_source.dart';
import '../models/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles() async {
    final box = Hive.box<NewsArticleModel>('news');
    try {
      final response = await remoteDataSource.getNewsArticles();
      return response.fold(
            (failure) async {
          final localArticles = box.values.toList();
          if (localArticles.isNotEmpty) {
            return Right(localArticles);
          } else {
            return Left(EmptyCacheFailure('No cached data available.'));
          }
        },
            (articles) async {
          await box.clear();
          await box.addAll(articles);
          return Right(articles);
        },
      );
    } catch (e) {
      // If an error occurs (e.g., no internet), return data from Hive
      final localArticles = box.values.toList();
      if (localArticles.isNotEmpty) {
        return Right(localArticles);
      } else {
        return Left(NetworkFailure('Failed to load news articles: ${e.toString()}'));
      }
    }
  }
}
