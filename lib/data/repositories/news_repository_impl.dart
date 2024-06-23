// lib/data/repositories/news_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_news_app/data/models/news_article_model.dart';

import 'news_repository.dart';


class NewsRepositoryImpl implements NewsRepository {


  NewsRepositoryImpl();

  @override
  Future<List<NewsArticleModel>> getNewsArticles() async {
    try {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=a9aa6d86b9574b08958d4f4be9e90659'));

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body)['articles'];
        return json.map((e) => NewsArticleModel.fromJson(e)).toList();
      } else {
        // Detailed error message
        throw Exception('Failed to load news articles: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      // Log the error or handle it appropriately
      print('Error occurred while fetching news articles: $error');
      throw Exception('Failed to load news articles: $error');
    }
  }
}
