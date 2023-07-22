import 'package:blog_rest_api_provider/provider/delete_post/delete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/update_post/update_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_notifier.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetAllPostNotifier()),
        ChangeNotifierProvider(create: (_) => GetCompletePostNOtifier()),
        ChangeNotifierProvider(create: (_) => BlogUploadNotifier()),
        ChangeNotifierProvider(create: (_) => UpdatePostNotifier()),
        ChangeNotifierProvider(create: (_) => DeletePostNotifier())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
