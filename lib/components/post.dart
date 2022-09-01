import 'package:flint/home.dart';
import 'package:flint/miscellaneous/post_data.dart';
import 'package:flint/skeletons/avatar.dart';
import 'package:flint/components/avatar.dart';
import 'package:flint/constants.dart';
import 'package:flint/skeletons/post.dart';
import 'package:flint/views/post_view.dart';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class Post extends StatefulWidget {
  Post({
    required this.postData,
             this.onDelete,
             this.isComment = false 
             }) : super(key: Key(postData.id));

  final PostData postData;
  final bool isComment;
  final Function? onDelete;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  bool showSkeleton = false;

  void deletePost() {
    setState(() => showSkeleton = true);

    supabase.from(widget.isComment ? "comments" : "posts").delete().match({"id": widget.postData.id}).execute().then((value) {
      if (value.hasError) {
        setState(() => showSkeleton = false);
        return;
      }
      if (widget.onDelete != null) widget.onDelete!();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelf = widget.postData.author == supabase.auth.currentUser!.id;

    final opts = PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          onTap: deletePost
        )
      ],
    );

    if (showSkeleton) return PostSkeleton();

    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            username: widget.postData.username, 
            date: widget.postData.date, 
            avatarUrl: widget.postData.avatarUrl, 
            options: isSelf ? opts : null
          ),
          const SizedBox(height: 20),
          SelectableText(widget.postData.content),
          const SizedBox(height: 20),
          if (!widget.isComment) Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite, color: Color.fromARGB(255, 132, 132, 132)), padding: EdgeInsets.zero),
              const SizedBox(width: 15),
              IconButton(onPressed: () => homeStateInstance?.changeWidgetRequest(PostView(postId: widget.postData.id)), icon: Icon(Icons.comment, color: Color.fromARGB(255, 132, 132, 132)), padding: EdgeInsets.zero),
              const SizedBox(width: 5),
              if (widget.postData.commentCount > 0) Container(child: Text("${widget.postData.commentCount}"), padding: EdgeInsets.fromLTRB(0, 0, 0, 4),)
            ],
          )
        ],
      ) 
    );
  }
}