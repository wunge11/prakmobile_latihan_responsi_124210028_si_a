import 'package:flutter/material.dart';
import 'list_blogs.dart';
import 'list_news.dart';
import 'list_reports.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Flight News',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Menu> menus = [
    Menu('News', 'assets/news.jpeg', 'Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites', PageListNews()),
    Menu('Blog', 'assets/blog.jpeg', 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast', PageListBlogs()),
    Menu('Reports', 'assets/report.jpeg', 'Access detailed reports and analyses', PageListReports()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space Flight News",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Menempatkan judul di tengah
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => menus[index].page,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    menus[index].imagePath,
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 16),
                  Text(
                    menus[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      menus[index].description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Menu menu;

  DetailPage({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          menu.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: menu.name,
              child: Image.asset(
                menu.imagePath,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Detail Page for ${menu.name}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu {
  final String name;
  final String imagePath;
  final String description;
  final Widget page;

  Menu(this.name, this.imagePath, this.description, this.page);
}
