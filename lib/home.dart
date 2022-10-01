import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flint/views/feed.dart';
import 'package:flint/views/person.dart';
import 'package:flint/views/people.dart';
import 'package:flint/constants.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _pages = ["Feed", "People", "Notifications", "Settings"];
  final _pageViews = [Feed(), People(), Container(), Container()];
  var _pageIndex = 0;
  
  Widget? _overlyingWidget;

  void changeWidgetRequest(Widget? overlapWidget) {
    setState(() {
      _overlyingWidget = overlapWidget;
    });
  }

  String get page {
    return _pages[_pageIndex];
  }

  Widget get pageView {
    return _pageViews[_pageIndex];
  }

  @override
  void initState() {
    // TODO: Implement
    homeStateInstance = this;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: Implement
    homeStateInstance = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    );

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    final navEls = [
      ..._pages.map((e) => 
        TextButton(
          key: Key(e),
          onPressed: () {
            setState(() {
              _overlyingWidget = null;
              _pageIndex = _pages.indexOf(e);
            });
          }, 
          child: Container(
            width: isMobile ? null : double.infinity,
            padding: const EdgeInsets.all(5),
            child: Text(e, style: hStyle),
          )
        )
      ).toList(),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: supabase.auth.signOut,
        child: Container(
          width: isMobile ? null : double.infinity,
          padding: const EdgeInsets.all(5),
          child: const Center(child: Text("Quit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0))),
        ),
      )
    ];

    final pageOpt = Column (
      children: [
        if (!isMobile) Container(  
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(minWidth: 600, maxWidth: 600),
          decoration: decor,
          child: Text(page, style: hStyle, textAlign: TextAlign.center,)
        ),
        Container(  
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          constraints: BoxConstraints(minWidth: 600, maxWidth: 600),
          child: _overlyingWidget ?? pageView,
        )
      ]
    );

    final pageEls = [
      Container(
        width: 250,
        padding: isMobile ? const EdgeInsets.fromLTRB(20, 20, 20, 0) : const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: decor,
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 600),
              child: isMobile
              ? SingleChildScrollView(
                child: Row(children: navEls),
                scrollDirection: Axis.horizontal,
              )
              : Column(
                children: navEls
              )
            ),
          ],
        ),
      ),

      isMobile ? pageOpt : Expanded(child: pageOpt),

      if (width > 1000) Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: decor,
              child: Column(
                children: [
                  Icon(Icons.verified_user, color: Theme.of(context).primaryColor, size: 175.0),
                  SizedBox(height: 10),
                  Text("Verified User", style: hStyle)
                ]
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: decor,
              width: double.infinity,
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", style: TextStyle(color: Theme.of(context).primaryColor),)
            ),
          ],
        ),
      ),
    ];

    return ListView(
      children: isMobile 
      ? pageEls 
      : [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pageEls
          ),
        )
      ],
    );
  }
}

_HomeState? homeStateInstance;