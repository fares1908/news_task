// lib/domain/use_cases/get_news_articles.dart
import 'package:task_news_app/domain/entities/news_article.dart';


import '../repositories/news_repository.dart';

class GetNewsArticles {
  final NewsRepository repository;

  GetNewsArticles(this.repository);

  Future<List<NewsArticle>> call() async {
    final models = await repository.getNewsArticles();
    return models.map((model) => NewsArticle(
      title: model.title,
      source: model.source?.name,
      author: model.author,
      description: model.description,
      url: model.url,
      urlToImage: model.urlToImage,
      publishedAt: model.publishedAt,
      content: model.content,
    )).toList();
  }
}
