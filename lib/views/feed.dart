import 'dart:collection';

import 'package:flint/components/alert.dart';
import 'package:flint/components/post.dart';
import 'package:flint/components/write.dart';
import 'package:flint/constants.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({ Key? key }) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<dynamic>? _posts;

  @override
  void initState() {
    // TODO: implement initState
    fetchPosts();
    super.initState();
  }

  void fetchPosts() {
    supabase.rpc("get_posts_v3").execute().then((value) {
      print(value.data);
      setState(() {
        _posts = value.data;
      });
    });
  }

  void onWrite(int status) {
    if (status == 0) setState(() => _posts = null);
    if (status == 1) fetchPosts();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Write(onWrite: onWrite),

          if (_posts == null) Alert(message: "Loading your feed..."),

          if (_posts != null && _posts!.isEmpty) Alert(message: "Your feed is empty."),

          if (_posts != null) ..._posts!.map(
          (e) => Post(
            id: e["id"], 
            author: e["author"], 
            content: e["content"], 
            username: e["username"], 
            date: e["created_at"],
            commentCount: e["comment_count"],
            avatarUrl: e["avatar_url"],
            )
          ).toList()
        ],
      ),
    );
  }
}