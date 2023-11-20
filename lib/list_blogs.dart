import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'detail_blogs.dart';
import 'blog_models.dart';

class PageListBlogs extends StatefulWidget {
  const PageListBlogs({Key? key}) : super(key: key);

  @override
  State<PageListBlogs> createState() => _PageListBlogsState();
}

class _PageListBlogsState extends State<PageListBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Blogs Terbaru",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildListBlogsBody(),
    );
  }

  Widget _buildListBlogsBody() {
    return Container(
      padding: EdgeInsets.all(16.0), // Tambahkan padding ke container
      child: FutureBuilder(
        future: ApiDataSource.instance.loadBlogs(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Blogs blogs = Blogs.fromJson(snapshot.data);
            return _buildSuccessSection(blogs);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Terjadi kesalahan",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildSuccessSection(Blogs data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemUsers(data.results![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemUsers(Results Blogs) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageDetailBlogs(blog: Blogs),
          ),
        );
      },
      child: Card(
        elevation: 4.0, // Tambahkan efek elevasi pada card
        margin: EdgeInsets.only(bottom: 16.0), // Beri margin ke bawah card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.network(
                Blogs.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Blogs.title!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    Blogs.summary!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
