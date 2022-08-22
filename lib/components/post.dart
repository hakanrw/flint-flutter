import 'package:flutter/material.dart';

import 'package:flint/components/avatar.dart';
import 'package:flint/constants.dart';

class Post extends StatelessWidget {
  Post({ 
    required this.id, 
    required this.author, 
    required this.content, 
    required this.username, 
    required this.date, 
    required this.avatarUrl,
    required this.commentCount }) : super(key: Key(id));

  final String id;
  final String author;
  final String username;
  final String content;
  final String date;
  final String? avatarUrl;
  final int commentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            username: username, 
            date: date, 
            avatarUrl: avatarUrl, 
            options: Container( child: FlatButton(
              onPressed: () {
              },
              shape: CircleBorder(),
              child: Icon(Icons.more_vert),
            ), width: 40)
          ),
          const SizedBox(height: 20),
          SelectableText(content),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.favorite, color: Color.fromARGB(255, 132, 132, 132)),
              const SizedBox(width: 15),
              Icon(Icons.comment, color: Color.fromARGB(255, 132, 132, 132)),
              const SizedBox(width: 5),
              if (commentCount > 0) Container(child: Text("$commentCount"), padding: EdgeInsets.fromLTRB(0, 0, 0, 4),)
            ],
          )
        ],
      ) 
    );
  }
}