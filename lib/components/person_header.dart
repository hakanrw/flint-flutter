import 'package:flutter/material.dart';

import '../constants.dart';
import 'avatar.dart';

class PersonHeader extends StatelessWidget {
  const PersonHeader({ Key? key, this.avatarUrl, this.username}) : super(key: key);

  final String? avatarUrl;
  final String? username;

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Avatar(username: username ?? "", avatarUrl:  avatarUrl ?? "", options: TextButton(onPressed: () {}, child: Text("PROFILE", style: TextStyle(fontWeight: FontWeight.bold),),)),
    );
  }
}