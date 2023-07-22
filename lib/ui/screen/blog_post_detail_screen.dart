import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/provider/delete_post/delete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:blog_rest_api_provider/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/ui/screen/delete_post_screen.dart';
import 'package:blog_rest_api_provider/ui/screen/update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPostDetailScreen extends StatefulWidget {
  const BlogPostDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getBlogDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<GetCompletePostNOtifier>(
            builder: (_, getCompletePostNotifier, __) {
          GetCompletePostState getCompletePostState =
              getCompletePostNotifier.getCompletePostState;
          if (getCompletePostState is GetCompletePostSuccess) {
            GetOnePostResponse getOnePostResponse =
                getCompletePostState.getOnePostResponse;
            return Text(getOnePostResponse.title!);
          } else if (getCompletePostState is GetCompletePostFail) {
            return Text(getCompletePostState.errorString);
          }
          return const Text('.............');
        }),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePostScreen(id: widget.id)));
              if (result != null && result == "success") {
                if (mounted) {
                  _getBlogDetail(widget.id);
                }
              }
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
              onPressed: () {
                Provider.of<DeletePostNotifier>(context, listen: false)
                    .deletePost(id: widget.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeletePostScreen(
                              id: widget.id,
                            )));
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Consumer<GetCompletePostNOtifier>(
          builder: (_, getcompletePostNotifier, __) {
        GetCompletePostState getCompletePostState =
            getcompletePostNotifier.getCompletePostState;
        if (getCompletePostState is GetCompletePostSuccess) {
          GetOnePostResponse getOnePostResponse =
              getCompletePostState.getOnePostResponse;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    getOnePostResponse.body ?? '',
                  ),
                  const Divider(),
                  if (getOnePostResponse.photo != null)
                    Image.network(
                        '${BlogApiService.baseUrl}${getOnePostResponse.photo}',
                        loadingBuilder: (context, child, loadingProgress) =>const CircularProgressIndicator.adaptive(),),
                ],
              ),
            ),
          );
        } else if (getCompletePostState is GetCompletePostFail) {
          return Column(
            children: [
              Text(getCompletePostState.errorString),
              const Divider(),
              ElevatedButton(
                  onPressed: () {
                    _getBlogDetail(widget.id);
                  },
                  child: const Text("Try Again"))
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }),
    );
  }

  void _getBlogDetail(int id) {
    Provider.of<GetCompletePostNOtifier>(context, listen: false)
        .getCompletePost(id: widget.id);
  }
}
