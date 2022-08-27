import 'package:flint/constants.dart';
import 'package:flint/skeletons/avatar.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PostSkeleton extends StatelessWidget {
  const PostSkeleton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarSkeleton(),
          const SizedBox(height: 20),
          SkeletonLine(),
          const SizedBox(height: 5),
          SkeletonLine(),
          const SizedBox(height: 5),
          SkeletonLine(style: SkeletonLineStyle(width: 200))
        ],
      ),
    );
  }
}