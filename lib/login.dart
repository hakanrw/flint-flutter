import 'package:flint/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? alert;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  void logIn() {
    if (kDebugMode) print("requesting login");
    setState(() {
      alert = "logging in...";
    });

    final username = usernameController.text;
    final password = passwordController.text;

    supabase.auth.signIn(email: username, password: password)
      .then((res) {
        if (res.error != null) setState(() => alert = res.error!.message);
      });
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    final pageEls = [
      if (!isMobile) Expanded(child: Center()),
      Container(
          child: Center(
            child: Container(width: isMobile ? 300 : 400, height: isMobile ? 150 : 300, 
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [
                    Color.fromARGB(255, 29, 29, 255),
                    Color.fromARGB(255, 73, 73, 255),
                    Color.fromARGB(255, 128, 128, 255),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ]
              ),
              child: Center(child: Text("flint", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48, color: Colors.white)))
            )
          ) 
        ),
      if (!isMobile) Expanded(child: Center()),
      Container(
        width: 300,
        margin: EdgeInsets.fromLTRB(10, 0, isMobile ? 10 : 40, 0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log In", style: Theme.of(context).textTheme.headline4,),
            SizedBox(height: 20), 
            TextField(
              onSubmitted: (_) => logIn(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              controller: usernameController,
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              onSubmitted: (_) => logIn(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              controller: passwordController,
            ),
            if (alert != null) Container(
              width: double.infinity,
              child: Text(alert!, style: TextStyle(color: Colors.white),),
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).primaryColor
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: logIn,
              child: Padding(padding: EdgeInsets.all(10), child: Text("Log In")),
            )
          ]
        ),
      ),
    ];

    return isMobile ? Column(children: pageEls, crossAxisAlignment: CrossAxisAlignment.center,) : Row(children: pageEls);
  }

}