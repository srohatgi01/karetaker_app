import 'dart:convert';

class BlogsHasKeyword {
  BlogsHasKeyword({
    required this.keywordName,
  });

  final String keywordName;

  factory BlogsHasKeyword.fromRawJson(String str) =>
      BlogsHasKeyword.fromJson(json.decode(str));

  factory BlogsHasKeyword.fromJson(Map<String, dynamic> json) =>
      BlogsHasKeyword(
        keywordName: json["keyword_name"] == null ? null : json["keyword_name"],
      );
}
