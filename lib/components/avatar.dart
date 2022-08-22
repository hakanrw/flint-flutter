import 'package:flint/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Avatar extends StatelessWidget {
  const Avatar({ Key? key, required this.username, this.date, required this.avatarUrl, this.options }) : super(key: key);
  
  final String username;
  final String? avatarUrl;
  final String? date;
  final Widget? options;

  @override
  Widget build(BuildContext context){
    final publicAvatarUrl = avatarUrl != null && avatarUrl != "" ? supabase.storage.from("avatars").getPublicUrl(avatarUrl!).data : null;

    return Container(
      child: Row(
        children: [
          CircleAvatar(backgroundImage: publicAvatarUrl != null ? NetworkImage(publicAvatarUrl) : null ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username),
              if (date != null) Text(DateFormat.yMMMMd().format(DateTime.parse(date!)), style: TextStyle(color: Color.fromARGB(255, 132, 132, 132))),
            ],
          ),
          Expanded(child: SizedBox()),
          if (options != null) options!
        ],
      )
    );
  }
}