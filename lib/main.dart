import 'package:flutter/material.dart';
import 'base_network_news.dart';
import 'home.dart';
import 'list_blogs.dart';
import 'list_news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Responsi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MenuPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Memanggil API dan menyimpan respon
  Future<Map<String, dynamic>> fetchData() async {
    final response = await BaseNetwork.get("articles/?format=json");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Menampilkan indikator loading jika masih menunggu respon dari API
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Menampilkan pesan error jika terjadi kesalahan
              return Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              // Menampilkan data dari API
              final data = snapshot.data;
              return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Text(
                  'Data from API: $data',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
