import 'package:dartz/dartz.dart';
import 'package:task_news_app/core/error/failure.dart';

import '../entities/news_article.dart';
import '../repositories/news_repository.dart';


class GetNewsArticlesUseCase {
  final NewsRepository repository;

  GetNewsArticlesUseCase(this.repository);

  Future<Either<Failure, List<NewsArticle>>> call() async {
    return await repository.getNewsArticles();

  }
}
