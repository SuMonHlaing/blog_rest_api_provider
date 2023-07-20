import 'package:blog_rest_api_provider/provider/update_post/update_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/update_post/update_post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key, required this.id});
  final int id;

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post Screen'),
        centerTitle: true,
      ),
      body: Consumer<UpdatePostNotifier>(builder: (_, updatePostNotifier, __) {
        UpdatePostState updatePostState = updatePostNotifier.updatePostState;
        if (updatePostState is UpdatePostLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (updatePostState is UpdatePostSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(updatePostState.updateResponse.result ?? ''),
              const Divider(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'success');
                    updatePostNotifier.updatePostState = UpdateForm();
                  },
                  child: const Text('ok'))
            ],
          );
        } else if (updatePostState is UpdatePostFail) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(updatePostState.errorMessage),
              const Divider(),
              ElevatedButton(onPressed: () {
                updatePostNotifier.updatePostState = UpdateForm();
              }, child: const Text('Try Again'))
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: 'Enter update title',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                    labelText: 'Enter update body',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _bodyController.text.isNotEmpty) {
                      String title = _titleController.text;
                      String body = _bodyController.text;
                      if (mounted) {
                        Provider.of<UpdatePostNotifier>(context, listen: false)
                            .update(id: widget.id, title: title, body: body);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill complete data')));
                    }
                  },
                  child: const Text(
                    'ok',
                  )),
            ],
          ),
        );
      }),
    );
  }
}
