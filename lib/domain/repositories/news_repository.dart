import 'package:dartz/dartz.dart';
import 'package:task_news_app/data/models/news_article_model.dart';
import 'package:task_news_app/core/error/failure.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles();
}
