import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/Register.dart';
import 'package:frontend/screens/auth/Login.dart';
import 'package:frontend/screens/categories/categories_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/categories': (context) => CategoriesList(),
      },
    );
  }
}
