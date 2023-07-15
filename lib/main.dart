import 'package:blog_rest_api_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_provider/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetAllPostNotifier(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
