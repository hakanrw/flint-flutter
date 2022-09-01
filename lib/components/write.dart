import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:flint/constants.dart';
import 'package:flutter/services.dart';

class Write extends StatefulWidget {
  Write({ Key? key, required this.onWrite, this.commentTo }) : super(key: key);

  String? commentTo;
  void Function(int) onWrite;

  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final writeController = TextEditingController();

  void sendWrite() {
    widget.onWrite(0);
    final _value = writeController.text;
    writeController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    
    supabase.rpc("create_post", params: {"content": _value}).execute().then((value) {
      widget.onWrite(1);
      if (value.error != null) writeController.text = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    );

    return Container(
      width: double.infinity,
      decoration: decor,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (value) {
              if ( (value is RawKeyDownEvent) == false) return;
              print(value);
              if (value.isControlPressed && value.physicalKey == PhysicalKeyboardKey.enter) sendWrite();
            },
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write',
              ),
              minLines: 4,
              maxLines: 4,
              controller: writeController,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(10), 
                  child: Text("Save", style: hStyle),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: sendWrite,
                child: Container(
                  padding: EdgeInsets.all(5), 
                  child: Text("Send", style: hStyle),
                )
              )
            ],
          )
        ]
      )
    );
  }
}