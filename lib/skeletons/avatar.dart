import 'package:flint/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AvatarSkeleton extends StatelessWidget {
  const AvatarSkeleton({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(width: 100),
              ),
              SizedBox(height: 5),
              SkeletonLine(
                style: SkeletonLineStyle(width: 150),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
        ],
      )
    );
  }
}