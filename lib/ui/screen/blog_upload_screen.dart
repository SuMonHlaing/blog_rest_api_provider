import 'dart:io';
import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_notifier.dart';
import 'package:blog_rest_api_provider/provider/upload_post/upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BlogUploadScreen extends StatefulWidget {
  const BlogUploadScreen({super.key});

  @override
  State<BlogUploadScreen> createState() => _BlogUploadScreenState();
}

class _BlogUploadScreenState extends State<BlogUploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Screen"),
        centerTitle: true,
      ),
      body: Consumer<BlogUploadNotifier>(
        builder: (_, blogUploadNotifier, __) {
          UplaoadUIState uplaoadUIState = blogUploadNotifier.uploadUIState;
          if (uplaoadUIState is UploadUILoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'uploading please wait........${uplaoadUIState.progress}%'),
                const Divider(),
                LinearProgressIndicator(
                  value: uplaoadUIState.progress,
                )
              ],
            );
          } else if (uplaoadUIState is UploadUISuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(uplaoadUIState.blogUploadResponse.result ?? ''),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'success');
                      blogUploadNotifier.uploadUIState = UploadForm();
                    },
                    child: const Text('ok'))
              ],
            );
          } else if (uplaoadUIState is UploadUIFail) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(uplaoadUIState.errorMessage),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      blogUploadNotifier.tryAgain();
                    },
                    child: const Text('Try Again'))
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        labelText: 'Enter your blog title',
                        border: OutlineInputBorder()),
                  ),
                  const Divider(),
                  TextField(
                    minLines: 3,
                    maxLines: 5,
                    controller: _bodyController,
                    decoration: const InputDecoration(
                        labelText: 'Enter your blog content',
                        border: OutlineInputBorder()),
                  ),
                  const Divider(),
                  FilledButton(
                      onPressed: () async {
                        XFile? file = await _imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            _image = File(file.path);
                          });
                        }
                      },
                      child: const Text('Select Photo')),
                  const Divider(),
                  if (_image != null)
                    Image.file(
                      _image!,
                      height: 200,
                    ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_titleController.text.isNotEmpty &&
                            _bodyController.text.isNotEmpty) {
                          String title = _titleController.text;
                          String body = _bodyController.text;
                          FormData? data;
                          if (_image != null) {
                            data = FormData.fromMap({
                              'photo':
                                  await MultipartFile.fromFile(_image!.path)
                            });
                          }
                          if (mounted) {
                            Provider.of<BlogUploadNotifier>(context,
                                    listen: false)
                                .upload(title: title, body: body, data: data);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Enter complete blog title and body')));
                        }
                      },
                      child: const Text("upload")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
