import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future delay() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(

            // image: DecorationImage(
            //   image: AssetImage('android/app/assets/download (1).jfif'),
            // )
            ),

        //child: Text("WELCOME TO PLAN MASTER", style: TextStyle(
        //fontSize: 20,
        // color: Colors.blueAccent,
        // ),),
      ),
    ));
  }
}
