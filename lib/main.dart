
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/product_controller.dart';
import 'views/product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHOPX',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const ProductScreen(),
    );
  }
}
