import 'package:flutter/material.dart';
import 'package:task_news_app/domain/entities/news_article.dart';

import 'package:flutter/material.dart';
import 'package:task_news_app/domain/entities/news_article.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'No title'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty) Image.network(article.urlToImage!),
            SizedBox(height: 16.0),
            Text(
              article.title ?? 'No title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Source: ${article.source ?? 'Unknown'}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8.0),
            Text(
              'Published: ${article.publishedAt ?? 'Unknown'}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8.0),
            Text(
              'Author: ${article.author ?? 'Unknown'}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            Text(
              article.content ?? 'No content',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}