import 'dart:convert';

import 'package:newsapp/module/home/model/artical_model.dart';

class HomeModel {
  final String status;
  final int totalResults;
  final List<Article> articles;

  HomeModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory HomeModel.fromJson(String str) => HomeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles:  json["articles"]==null||json["articles"]==[]
        ? []
        : List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
  };
}