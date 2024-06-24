import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String? title;
  final String? source;
  final String? author;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  NewsArticle({
    this.title,
    this.source,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
    title,
    source,
    author,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
  ];
}
