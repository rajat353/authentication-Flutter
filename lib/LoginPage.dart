import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/animation.dart';
import 'package:authentication_flutter/LinkedIn.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //To enable the status panel
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation animationLeft, animationRight;
  AnimationController animationController;
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animationLeft = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));
    animationRight = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    animationController.forward();
  }

  Future<bool> onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.black54,
            shape: Border.all(color: Colors.white),
            title: new Text('Are you sure?',
                style: TextStyle(color: Colors.white)),
            content: new Text('Do you want to exit?',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              new FlatButton(
                splashColor: Colors.white,
                shape: Border.all(color: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              new FlatButton(
                splashColor: Colors.white,
                shape: Border.all(color: Colors.white),
                onPressed: () => exit(0),
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform(
                        transform: Matrix4.translationValues(
                            animationLeft.value * width, 0.0, 0.0),
                        child: Text("Mimoto Card",
                            style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RoundedElegance",
                                color: Colors.white)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animationRight.value * width, 0.0, 0.0),
                        child: Text("ABOUT US",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Times New Roman",
                                color: Colors.white)),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      TypewriterAnimatedTextKit(
                        speed: Duration(milliseconds: 200),
                        text: ["Log In to Explore"],
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "RoundedElegance",
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        totalRepeatCount: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animationLeft.value * width, 0.0, 0.0),
                        child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Image.asset(
                                    'images/instagram.png',
                                    height: 45.0,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    'Countinue with Instagram',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: "RoundedElegance",
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                            ),
                            onTap: () {}),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animationRight.value * width, 0.0, 0.0),
                        child: Text(
                          '----------Or----------',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "RoundedElegance",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animationLeft.value * width, 0.0, 0.0),
                        child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Image.asset(
                                    'images/linkedin.png',
                                    height: 45.0,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    'Continue with LinkedIn',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: "RoundedElegance",
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LinkedIn()));
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Contact Us',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15.0,
                          fontFamily: "RoundedElegance",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
