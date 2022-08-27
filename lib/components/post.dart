import 'package:flint/skeletons/avatar.dart';
import 'package:flint/components/avatar.dart';
import 'package:flint/constants.dart';
import 'package:flint/skeletons/post.dart';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class Post extends StatefulWidget {
  Post({ 
    required this.id, 
    required this.author, 
    required this.content, 
    required this.username, 
    required this.date, 
    required this.avatarUrl,
    required this.commentCount,
             this.onDelete }) : super(key: Key(id));

  final String id;
  final String author;
  final String username;
  final String content;
  final String date;
  final String? avatarUrl;
  final int commentCount;
  final bool isComment = false;
  final Function? onDelete;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  bool showSkeleton = false;

  void deletePost() {
    setState(() => showSkeleton = true);

    supabase.from(widget.isComment ? "comments" : "posts").delete().match({"id": widget.id}).execute().then((value) {
      if (value.hasError) {
        setState(() => showSkeleton = false);
        return;
      }
      if (widget.onDelete != null) widget.onDelete!();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelf = widget.author == supabase.auth.currentUser!.id;

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
            username: widget.username, 
            date: widget.date, 
            avatarUrl: widget.avatarUrl, 
            options: isSelf ? opts : null
          ),
          const SizedBox(height: 20),
          SelectableText(widget.content),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.favorite, color: Color.fromARGB(255, 132, 132, 132)),
              const SizedBox(width: 15),
              Icon(Icons.comment, color: Color.fromARGB(255, 132, 132, 132)),
              const SizedBox(width: 5),
              if (widget.commentCount > 0) Container(child: Text("${widget.commentCount}"), padding: EdgeInsets.fromLTRB(0, 0, 0, 4),)
            ],
          )
        ],
      ) 
    );
  }
}