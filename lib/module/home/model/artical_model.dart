
import 'dart:convert';

class Article {
  final Source? source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    source: json["source"]==null?null: Source.fromMap(json["source"]),
    author: json["author"]??"",
    title: json["title"]??"",
    description: json["description"]??"",
    url: json["url"]??"",
    urlToImage: json["urlToImage"]??"",
    publishedAt: json["publishedAt"]??"",
    content: json["content"]??"",
  );

  Map<String, dynamic> toMap() => {
    "source": source!.toMap(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt,
    "content": content,
  };
}

class Source {
  final dynamic id;
  final String name;
  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
