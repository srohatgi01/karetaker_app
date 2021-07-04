// To parse this JSON data, do
//
//     final blogs = blogsFromJson(jsonString);

import 'dart:convert';

import 'keywords.dart';

class Blogs {
  Blogs({
    required this.blogId,
    required this.title,
    this.body,
    required this.writtenBy,
    this.blogsHasKeywords,
  });

  final int blogId;
  final String title;
  final String? body;
  final String writtenBy;
  final List<BlogsHasKeyword>? blogsHasKeywords;

  factory Blogs.fromRawJson(String str) => Blogs.fromJson(json.decode(str));

  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        blogId: json["blog_id"] == null ? null : json["blog_id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        writtenBy: json["written_by"] == null ? null : json["written_by"],
        blogsHasKeywords: json["blogs_has_keywords"] == null
            ? null
            : List<BlogsHasKeyword>.from(json["blogs_has_keywords"]
                .map((x) => BlogsHasKeyword.fromJson(x))),
      );

  // Data coming for random blogs shall come here
  factory Blogs.randomFromRawJson(String str) =>
      Blogs.randomFromJson(json.decode(str));

  factory Blogs.randomFromJson(Map<String, dynamic> json) => Blogs(
        title: json["title"] == null ? null : json["title"],
        writtenBy: json["written_by"] == null ? null : json["written_by"],
        blogId: json["blog_id"] == null ? null : json["blog_id"],
      );
}
