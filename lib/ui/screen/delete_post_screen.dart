import 'package:blog_rest_api_provider/provider/delete_post/delete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/delete_post/delete_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_provider/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeletePostScreen extends StatefulWidget {
  const DeletePostScreen({super.key, required this.id});
  final int id;

  @override
  State<DeletePostScreen> createState() => _DeletePostScreenState();
}

class _DeletePostScreenState extends State<DeletePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
            Consumer<DeletePostNotifier>(builder: (_, deletePostNotifier, __) {
          DeletePostState deletePostState = deletePostNotifier.deletePostState;
          if (deletePostState is DeletePostFail) {
            return Text(deletePostState.errorMessage);
          } else if (deletePostState is DeletePostSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(deletePostState.deletePostResponse.result ?? ''),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context,
                              (Route<dynamic> predicate) => predicate.isFirst);
                          Provider.of<GetAllPostNotifier>(context, listen: false)
                              .getAllPost();
                        },
                        child: const Text('ok'))
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }));
  }
}
