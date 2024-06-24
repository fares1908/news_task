import 'package:hive/hive.dart';
import '../../domain/entities/news_article.dart';

part 'news_article_model.g.dart';

@HiveType(typeId: 0)
class NewsArticleModel extends NewsArticle with HiveObjectMixin {
  @override
  @HiveField(0)
  final String? title;

  @override
  @HiveField(1)
  final String? source;

  @override
  @HiveField(2)
  final String? author;

  @override
  @HiveField(3)
  final String? description;

  @override
  @HiveField(4)
  final String? url;

  @override
  @HiveField(5)
  final String? urlToImage;

  @override
  @HiveField(6)
  final String? publishedAt;

  @override
  @HiveField(7)
  final String? content;

  NewsArticleModel({
    this.title,
    this.source,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  }) : super(
    title: title,
    source: source,
    author: author,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      title: json['title'] as String?,
      source: json['source']['name'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source': source,
      'author': author,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
