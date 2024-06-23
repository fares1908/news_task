// lib/data/models/news_article_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  final String? title;
  final SourceModel? source;
  final String? author;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
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
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) => _$NewsArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String? name;

  SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
