import 'package:task_news_app/data/data_sources/news_remote_data_source.dart';
import 'package:task_news_app/data/models/news_article_model.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NewsArticleModel>> getNewsArticles() async {
    try {
      return await remoteDataSource.getNewsArticles();
    } catch (error) {
      print('Error occurred while fetching news articles: $error');
      throw Exception('Failed to load news articles: $error');
    }
  }
}
