import 'package:article_screen/presentation/views/ui/artilcle_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NY Times Most Popular Articles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NYArticlePage(),
    );
  }
}


