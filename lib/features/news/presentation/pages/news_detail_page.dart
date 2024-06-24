import 'package:flutter/material.dart';

import '../../domain/entities/news_article.dart';



class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(article.title ?? 'No title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty) Image.network(article.urlToImage!),
            const SizedBox(height: 16.0),
            Text(
              article.title ?? 'No title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Source: ${article.source ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Published: ${article.publishedAt ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Author: ${article.author ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16.0),
            Text(
              article.content ?? 'No content',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}