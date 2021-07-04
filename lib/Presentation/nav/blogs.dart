import 'package:flutter/material.dart';
import 'package:karetaker/data/models/blogs.dart';
import 'package:karetaker/data/repositories/blogs_repo.dart';

import 'features/blog_details.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  var inputedTextFieldText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextFormField(
          onChanged: (value) {
            this.setState(() {
              inputedTextFieldText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search here',
          ),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: inputedTextFieldText.isEmpty
            ? Stream.fromFuture(
                BlogsRepo().getRandomBlogs(),
              )
            : Stream.fromFuture(
                BlogsRepo().searchBlogs(
                  searchText: inputedTextFieldText,
                ),
              ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var randomBlogList = snapshot.data as List<Blogs>;

            return blogSearchCard(randomBlogList);
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else
            return Text('Random not working');
        },
      ),
    );
  }

  ListView blogSearchCard(List<Blogs> randomBlogList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: randomBlogList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BlogDetails(blogId: randomBlogList[index].blogId),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 8,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 20,
                  bottom: 20,
                ),
                child: Text(
                  randomBlogList[index].title.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Written By - ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        randomBlogList[index].writtenBy,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
