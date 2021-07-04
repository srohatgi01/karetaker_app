import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class BlogsApi {
  getRandomBlogs() async {
    try {
      var response = await http.get(Uri.parse(GET_RANDOM_BLOGS));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Random blogs error $e');
    }
  }

  searchBlogs({required String searchText}) async {
    try {
      var response = await http.get(Uri.parse(SEARCH_BLOGS + searchText));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Search Blogs Error: $e');
    }
  }

  getBlogById({required blogId}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_BLOG_BY_ID + blogId.toString()));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Get Blog by Id Error: $e');
    }
  }
}
