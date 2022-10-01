import 'package:flutter/material.dart';

import '../constants.dart';

class People extends StatefulWidget {
  const People({ Key? key }) : super(key: key);

  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    final searchField = TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Search for people',
      ),
      controller: searchController,
    );

    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: decor,
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                isMobile
                ? Expanded(
                  child: searchField,
                )
                : Container(
                  width: 250,
                  child: searchField 
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Padding( padding: EdgeInsets.fromLTRB(5, 16, 5, 16), child: const Text("SEARCH", style: TextStyle(fontWeight: FontWeight.bold,))),
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}