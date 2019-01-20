// This program display the Login Page

// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'dart:async';

// Import Self Darts
import 'bottom.dart';
import 'gv.dart';
import 'Home.dart';
import 'LangStrings.dart';
import 'SettingsMain.dart';
import 'tmpSettings.dart';


// Login Page
class ClsLogin extends StatefulWidget {
  @override
  _ClsLoginState createState() => _ClsLoginState();
}

class _ClsLoginState extends State<ClsLogin> {
  int intCounter = 0;

  static String strErrMessage = 'Error';

  bool bolLoading = false;

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funLoginPressed() {
    // Show Loading
    setState(() {
      bolLoading = true;
      gv.bolBottomLoading = true;
    });

    // Send to server that client wants to login
    gv.socket.emit('LoginToServer', [ctlUserID.text, ctlUserPW.text]);


    //Simulate a service call
    print('submittingo backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        bolLoading = false;
        gv.bolBottomLoading = false;
      });
    });
  }

  final ctlUserID = TextEditingController();
  final ctlUserPW = TextEditingController();

  Widget Body() {
    return Center(
      child: Container(
        color: Colors.white,
        height: sv.dblBodyHeight,
        width: sv.dblScreenWidth,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(' '),
              Text(strErrMessage),
              Text(' '),
              Row(
                children: <Widget>[
                  Text(gv.Space(sv.gintSpaceTextField)),
                  Expanded(
                    child: TextFormField(
                      controller: ctlUserID,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: ls.gs('UserID'),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                  Text(gv.Space(sv.gintSpaceTextField)),
                ],
              ),
              Text(' '),
              Row(
                children: <Widget>[
                  Text(gv.Space(sv.gintSpaceTextField)),
                  Expanded(
                    child: TextFormField(
                      controller: ctlUserPW,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: ls.gs('UserPW'),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                  Text(gv.Space(sv.gintSpaceTextField)),
                ],
              ),
              Text(' '),
              Text(' '),
              Row(
                children: <Widget>[
                  Text(gv.Space(sv.gintSpaceBigButton)),
                  Expanded(
                    child: SizedBox(
                      height: sv.dblDefaultFontSize * 2.5,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                sv.dblDefaultRoundRadius)),
                        textColor: Colors.white,
                        color: Colors.greenAccent,
                        onPressed: () => funLoginPressed(),
                        child: Text('Login',
                            style:
                                TextStyle(fontSize: sv.dblDefaultFontSize * 1)),
                      ),
                    ),
                  ),
                  Text(gv.Space(sv.gintSpaceBigButton)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('Login'),
            style: TextStyle(fontSize: sv.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(sv.dblTopHeight),
      ),
      body: ModalProgressHUD(child: Body(), inAsyncCall: bolLoading),
      bottomNavigationBar:ClsBottom(),
    );
  }
}
