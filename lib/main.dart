import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flint/constants.dart';
import 'package:flint/home.dart';
import 'package:flint/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:material_color_gen/material_color_gen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dfkznrcuushzudxsjxuj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMTAxMjE5OSwiZXhwIjoxOTM2NTg4MTk5fQ.2-kPn6J8Y8v1TOPmHdbPXP-UxRo1TpcL1zj6LKKBCYo',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flint',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: const Color.fromARGB(255, 25, 118, 210).toMaterialColor(),
      ),
      home: const LaunchPage(title: 'Flint'),
    );
  }
}

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key, required this.title}) : super(key: key);
  
  final String title;
  
  @override
  State<StatefulWidget> createState() => _LaunchPageState();

}

class _LaunchPageState extends State<LaunchPage> {
  var _signedIn = false;
  var _waiting = false;

  @override
  void initState() {
    
    if (supabase.auth.currentSession != null) {
      setState(() => _signedIn = true);
    }

    supabase.auth.onAuthStateChange((event, session) { 
      print(event);
      print("state changed!!!!");

      if (event == AuthChangeEvent.signedIn) setState(() => _signedIn = true);
      if (event == AuthChangeEvent.signedOut) setState(() => _signedIn = false);

      prefs.then((pref) => pref.setString("session_json", jsonEncode({'currentSession': session?.toJson(), 'expiresAt': session?.expiresAt})));

    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _waiting ? const Center(child: CircularProgressIndicator()) : _signedIn ? const Home() : const Login(),
    );
  }
  
}