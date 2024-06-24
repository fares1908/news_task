import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:task_news_app/core/error/failure.dart';
import '../models/news_article_model.dart';

abstract class NewsLocalDataSource {
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticlesFromCache();
  Future<void> cacheNewsArticles(List<NewsArticleModel> articles);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final Box<NewsArticleModel> box;

  NewsLocalDataSourceImpl({required this.box});

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticlesFromCache() async {
    try {
      final localArticles = box.values.toList();
      if (localArticles.isNotEmpty) {
        return Right(localArticles);
      } else {
        return Left(EmptyCacheFailure('No cached data available.'));
      }
    } catch (e) {
      return Left(CacheFailure('Failed to load cached data: ${e.toString()}'));
    }
  }

  @override
  Future<void> cacheNewsArticles(List<NewsArticleModel> articles) async {
    await box.clear();
    await box.addAll(articles);
  }
}
