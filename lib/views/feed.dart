import 'dart:collection';

import 'package:flint/components/alert.dart';
import 'package:flint/components/post.dart';
import 'package:flint/components/write.dart';
import 'package:flint/constants.dart';
import 'package:flint/miscellaneous/post_data.dart';
import 'package:flint/skeletons/post.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({ Key? key }) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  
  bool _hasLoadingPost = false;
  List<PostData>? _posts;

  @override
  void initState() {
    // TODO: implement initState
    fetchPosts();
    super.initState();
  }

  void fetchPosts() {
    supabase.rpc("get_posts_v3").execute().then((value) {
      print(value.data.runtimeType);
      setState(() {
        _posts = value.data.map<PostData>((value) => PostData.fromJson(value)).toList();
        _hasLoadingPost = false;
      });
    });
  }

  void onWrite(int status) {
    if (status == 0) setState(() => _hasLoadingPost = true);
    if (status == 1) fetchPosts();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Write(onWrite: onWrite),

          if (_hasLoadingPost) PostSkeleton(),

          if (_posts == null) ...[PostSkeleton(), PostSkeleton(),],

          if (_posts != null && _posts!.isEmpty) Alert(message: "Your feed is empty."),

          if (_posts != null) ..._posts!.map(
            (post) => Post(postData: post, onDelete: fetchPosts)
          ).toList()
        ],
      ),
    );
  }
}