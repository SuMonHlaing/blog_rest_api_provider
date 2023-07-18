import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_provider/ui/screen/blog_post_detail_screen.dart';
import 'package:blog_rest_api_provider/ui/screen/blog_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAllPost(context);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Api Lessons"),
        centerTitle: true,
      ),
      body: Consumer<GetAllPostNotifier>(builder: (_, getAllProvider, __) {
        GetAllPostState getAllPostState = getAllProvider.getAllPostState;
        if (getAllPostState is GetAllPostSuccess) {
          List<GetAllPostResponse> getAllPostResponseList =
              getAllPostState.getAllPostList;
          return GetAllPostWidget(
              getAllPostResponseList: getAllPostResponseList);
        } else if (getAllPostState is GetAllPostFail) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ooops Something wrong"),
              const Divider(),
              ElevatedButton(
                  onPressed: () {
                    _getAllPost(context);
                  },
                  child: const Text('Try again'))
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }),
   floatingActionButton: FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> const BlogUploadScreen()));
    }), );
  }

  void _getAllPost(BuildContext ctx) {
    Provider.of<GetAllPostNotifier>(ctx, listen: false).getAllPost();
  }
}

class GetAllPostWidget extends StatelessWidget {
  const GetAllPostWidget({
    super.key,
    required this.getAllPostResponseList,
  });

  final List<GetAllPostResponse> getAllPostResponseList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: getAllPostResponseList.length,
        itemBuilder: (context, index) {
          GetAllPostResponse getAllPostResponse = getAllPostResponseList[index];
          return InkWell(
            onTap: () {
              if (getAllPostResponse.id != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BlogPostDetailScreen(id: getAllPostResponse.id!)));
              }
            },
            child: Card(
              child: ListTile(
                title: Text('${getAllPostResponse.title}'),
              ),
            ),
          );
        });
  }
}
