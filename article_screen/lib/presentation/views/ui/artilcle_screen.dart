


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NYArticlePage extends StatefulWidget {
  const NYArticlePage({super.key});

  @override
  _NYArticlePageState createState() => _NYArticlePageState();
}

class _NYArticlePageState extends State<NYArticlePage> {
  List NyTimesArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nyArticles();
  }

  Future<void> _nyArticles() async {
    const String apiKey = 'j2u4KmEYAVcACkK16YSFkDARJyQjpE8H';
    const String apiUrl = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final articleData = json.decode(response.body);

      setState(() {
        NyTimesArticles = articleData['results'];
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('NY Times Most Popular '),
        leading: const Icon(
          Icons.menu,
        ),
        actions:  <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: NyTimesArticles.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Text(NyTimesArticles[index]['title'],style: const TextStyle(fontSize: 14),
                  maxLines: 2,overflow: TextOverflow.ellipsis),
                subtitle: Text(NyTimesArticles[index]['abstract'],style: const TextStyle(fontSize: 12),
                    maxLines: 1,overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailPage(article: NyTimesArticles[index]),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:22.0),
                    child: Text(NyTimesArticles[index]['source'],style: const TextStyle(fontSize: 14,color: Colors.grey)),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 14.0,
                        color: Colors.grey,
                      ),
                      Text(NyTimesArticles[index]['published_date'],style: const TextStyle(fontSize: 14,color: Colors.grey)),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final dynamic article;

  ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text("Details"),
      ),
      body: const Padding(
        padding:  EdgeInsets.all(16.0),
        child:  Center(
          child: Text(
            "NO DATA",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
