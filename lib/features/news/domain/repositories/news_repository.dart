import 'package:dartz/dartz.dart';

import 'package:task_news_app/core/error/failure.dart';

import '../../data/models/news_article_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles();
}
