import 'package:flint/components/post.dart';
import 'package:flint/components/write.dart';
import 'package:flint/constants.dart';
import 'package:flint/home.dart';
import 'package:flint/miscellaneous/post_data.dart';
import 'package:flint/skeletons/post.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({ Key? key, required this.postId }) : super(key: key);

  final String postId;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  PostData? _postData;

  @override
  void initState() {
    // TODO: implement initState
    fetchPost();
    super.initState();
  }

  Future<void> fetchPost() async {
    final post = await supabase.from("posts").select("*").filter("id", "eq", widget.postId).execute();
    
    if (post.error != null || post.data.length == 0) {
      print("no such post?");
      homeStateInstance?.changeWidgetRequest(null);
      return;
    }

    final data = await Future.wait(
      [
        supabase.from("profiles").select("*").filter("id", "eq", post.data[0]["author"]).execute(),
        supabase.rpc("get_comments", params: { "post": post.data[0]["id"] }).execute(),
      ]
    );

    setState(() => _postData = PostData.fromJson({ ...data[0].data[0] as Map, ...post.data[0] as Map, "comment_count": data[1].data.length }));
    
  }

  @override
  Widget build(BuildContext context) {
    if (_postData == null) return Container(
      child: PostSkeleton(),
    );

    return Container(
      child: Column(
        children: [
          Post(postData: _postData!, onDelete: () => homeStateInstance?.changeWidgetRequest(null)),
          Write(onWrite: (_) {}, commentTo: _postData!.id),
          PostSkeleton(),
        ],
      ),
    );
  }
}