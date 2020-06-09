import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:authentication_flutter/LoginPage.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //To disable the status panel
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: ColorizeAnimatedTextKit(
            text: ["MIMOTO CARD"],
            textStyle: TextStyle(
              fontSize: 50.0,
              fontFamily: "Horizon",
            ),
            totalRepeatCount: 1,
            colors: [
              Colors.blue,
              Colors.yellow,
              Colors.red,
              Colors.white60,
            ],
            textAlign: TextAlign.center,
            alignment: AlignmentDirectional.topStart,
            onFinished: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ));
  }
}
