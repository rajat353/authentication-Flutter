import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:authentication_flutter/LoginPage.dart';

final String redirectUrl = 'https://app.test.in';
final String clientId = '86h64b34u8ki5a';
final String clientSecret = 'ttSHAwridQ7TShbA';

bool logoutUser = false;

class UserObject {
  String userID, firstName, lastName, email;
  UserObject({this.firstName, this.lastName, this.email, this.userID});
}

class LinkedIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinkedInState();
  }
}

class LinkedInState extends State<LinkedIn> {
  UserObject user;
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              backgroundColor: Colors.black,
              title: new Text('Are you sure?',
                  style: TextStyle(color: Colors.white)),
              content: new Text('Do you want to exit?',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => exit(0),
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

    return LinkedInUserWidget(
      appBar: AppBar(
        title: Text('LinkedIn Login'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      destroySession: logoutUser,
      redirectUrl: redirectUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      onGetUserProfile: (LinkedInUserModel linkedInUser) {
        print('Access token ${linkedInUser.token.accessToken}');

        print('User-id: ${linkedInUser.userId}');

        user = UserObject(
          userID: linkedInUser.userId,
          firstName: linkedInUser.firstName.localized.label,
          lastName: linkedInUser.lastName.localized.label,
          email: linkedInUser.email.elements[0].handleDeep.emailAddress,
        );
        setState(() {
          logoutUser = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WillPopScope(
                    onWillPop: onWillPop,
                    child: Scaffold(
                        backgroundColor: Colors.blueGrey[900],
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          title: Text('Profile'),
                          centerTitle: true,
                          backgroundColor: Colors.black,
                        ),
                        body: Center(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Column(children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    user.firstName + ' ' + user.lastName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  Text('UserID: ' + user.userID,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text(user.email,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  SizedBox(height: 10),
                                  RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        user = null;
                                        logoutUser = true;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      });
                                    },
                                    child: Text('Logout'),
                                  ),
                                ])))))));
      },
      catchError: (LinkedInErrorObject error) {
        print('Error description: ${error.description},'
            ' Error code: ${error.statusCode.toString()}');
        Navigator.pop(context);
      },
    );
  }
}
