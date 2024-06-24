import 'package:dartz/dartz.dart';

import 'package:task_news_app/core/error/failure.dart';
import '../entities/news_article.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsArticle>>> getNewsArticles();
}
