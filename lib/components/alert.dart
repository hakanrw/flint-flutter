import 'package:flint/components/avatar.dart';
import 'package:flint/constants.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  Alert({ Key? key, required this.message }) : super(key: key);

  final String message;

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    final hStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    );

    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Center(child: Text(widget.message, style: hStyle))
    );
  }
}