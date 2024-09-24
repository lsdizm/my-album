import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyAlbumApp());
}

class MyAlbumApp extends StatelessWidget {
  const MyAlbumApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Race',
      theme: ThemeData(        
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey[900], // 배경색 설정
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // 기본 글자 색 흰색
          bodyMedium: TextStyle(color: Colors.white), // 기본 글자 색 흰색
        ),
      ),      
      home: const Home(),
    );
  }
}