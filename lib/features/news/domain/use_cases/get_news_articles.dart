import 'package:dartz/dartz.dart';
import 'package:task_news_app/core/error/failure.dart';

import '../entities/news_article.dart';
import '../repositories/news_repository.dart';


class GetNewsArticlesUseCase {
  final NewsRepository repository;

  GetNewsArticlesUseCase(this.repository);

  Future<Either<Failure, List<NewsArticle>>> call() async {
    final result = await repository.getNewsArticles();
    return result.map(
          (models) => models.map(
            (model) => NewsArticle(
          title: model.title,
          source: model.source,
          author: model.author,
          description: model.description,
          url: model.url,
          urlToImage: model.urlToImage,
          publishedAt: model.publishedAt,
          content: model.content,
        ),
      ).toList(),
    );
  }
}
