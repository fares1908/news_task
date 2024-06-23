// lib/domain/repositories/news_repository.dart
import 'package:task_news_app/data/models/news_article_model.dart';

abstract class NewsRepository {
  Future<List<NewsArticleModel>> getNewsArticles();
}

