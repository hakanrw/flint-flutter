import 'package:flint/components/person_header.dart';
import 'package:flint/skeletons/person_header.dart';
import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  const Person({ Key? key }) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PersonHeaderSkeleton()
        ],
      ),
    );
  }
}