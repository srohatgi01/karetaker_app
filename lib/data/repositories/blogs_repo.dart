import 'package:karetaker/data/models/blogs.dart';
import 'package:karetaker/data/provider/blogs_api.dart';

class BlogsRepo {
  getRandomBlogs() async {
    var decodedJson = await BlogsApi().getRandomBlogs();
    List<Blogs> blogs = [];

    for (var blog in decodedJson) {
      var b = Blogs.randomFromJson(blog);
      blogs.add(b);
    }

    return blogs;
  }

  searchBlogs({required String searchText}) async {
    var decodedJson = await BlogsApi().searchBlogs(searchText: searchText);
    List<Blogs> blogs = [];

    for (var blog in decodedJson) {
      var b = Blogs.randomFromJson(blog);
      blogs.add(b);
    }

    return blogs;
  }

  getBlogById({required blogId}) async {
    var decodedJson = await BlogsApi().getBlogById(blogId: blogId);

    var blog = Blogs.fromJson(decodedJson);
    return blog;
  }
}
