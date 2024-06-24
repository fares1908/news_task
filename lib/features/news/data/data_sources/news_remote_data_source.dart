import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task_news_app/core/error/failure.dart';

import '../models/news_article_model.dart';

abstract class NewsRemoteDataSource {
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles() async {
    try {
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=a9aa6d86b9574b08958d4f4be9e90659'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body)['articles'];
        return Right(json.map((e) => NewsArticleModel.fromJson(e)).toList());
      } else {
        return Left(ServerFailure('Failed to load news articles: ${response.statusCode} ${response.reasonPhrase}'));
      }
    } catch (e) {
      return Left(NetworkFailure('Failed to load news articles: ${e.toString()}'));
    }
  }
}
