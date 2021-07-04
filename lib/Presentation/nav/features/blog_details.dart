import 'package:flutter/material.dart';
import 'package:karetaker/data/models/blogs.dart';
import 'package:karetaker/data/repositories/blogs_repo.dart';

class BlogDetails extends StatelessWidget {
  final blogId;
  const BlogDetails({Key? key, required this.blogId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
              future: BlogsRepo().getBlogById(blogId: blogId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var blog = snapshot.data as Blogs;
                  print(blog.blogId);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Written By - ', style: TextStyle(fontSize: 18)),
                          Text(
                            blog.writtenBy,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(blog.body!, style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                        itemCount: blog.blogsHasKeywords!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              // border: Border.all(
                              //   color: Color(PRIMARY_COLOR),
                              // ),
                              ),
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child:
                              Text(blog.blogsHasKeywords![index].keywordName),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('');
                }
              }),
        ),
      ),
    );
  }
}
