import 'package:flutter/material.dart';

import '../constants.dart';
import 'avatar.dart';

class PersonHeaderSkeleton extends StatelessWidget {
  const PersonHeaderSkeleton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: AvatarSkeleton(),
    );
  }
}