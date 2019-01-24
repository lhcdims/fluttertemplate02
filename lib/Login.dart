// This program display the Login Page

// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';
import 'Utilities.dart';

// Login Page
class ClsLogin extends StatefulWidget {
  @override
  _ClsLoginState createState() => _ClsLoginState();
}

class _ClsLoginState extends State<ClsLogin> {
  int intCounter = 0;

  static String strErrMessage = 'Error';

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funLoginPressed() {
    // Reset login result
    gv.aryLoginResult = [];

    // Show Loading
    setState(() {
      gv.bolLoading = true;
    });

    // Send to server that client wants to login
    gv.socket.emit('LoginToServer', [ctlUserID.text, ctlUserPW.text]);

    // Start Login Time in ms
    gv.timLogin = DateTime.now().millisecondsSinceEpoch;

    new Future.delayed(new Duration(seconds: 1), () {
      while (gv.bolLoading) {
        // Use string to check if it is array
        if (gv.aryLoginResult.toString() == '[]') {
          // this means the server didnt return any value
          if (DateTime.now().millisecondsSinceEpoch - gv.timLogin > 5000) {
            gv.bolLoading = false;
            print('Login Fail');
            setState(() {
              gv.bolLoading = false;
            });
            ut.showToast(ls.gs('LoginFailed'));
          } else {
            gv.bolLoading = true;
            setState(() {
              gv.bolLoading = true;
            });
          }
        } else {
          // this means that server has returned some values
          if (gv.aryLoginResult[0] == '0000') {
            gv.bolLoading = false;
            print('Login Success');
            // Hide Loading
            setState(() {
              gv.bolLoading = false;
            });
            // Show Login success
            ut.showToast(ls.gs('LoginSuccess'));
            // Do other things

          } else if (gv.aryLoginResult[0] == '1000') {
            gv.bolLoading = false;
            print('Login Fail');
            // Hide Loading
            setState(() {
              gv.bolLoading = false;
            });
            // Show Login success
            ut.showToast(ls.gs('LoginFailed'));
            // Do other things

          } else {
            gv.bolLoading = true;
            setState(() {
              gv.bolLoading = true;
            });
          }
        }
      }
    });
  }

  void showAlert(BuildContext context, strTitle, strContent) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(strTitle),
              content: Text(strContent),
            ));
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
                  Text(ut.Space(sv.gintSpaceTextField)),
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
                  Text(ut.Space(sv.gintSpaceTextField)),
                ],
              ),
              Text(' '),
              Row(
                children: <Widget>[
                  Text(ut.Space(sv.gintSpaceTextField)),
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
                  Text(ut.Space(sv.gintSpaceTextField)),
                ],
              ),
              Text(' '),
              Text(' '),
              Row(
                children: <Widget>[
                  Text(ut.Space(sv.gintSpaceBigButton)),
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
                  Text(ut.Space(sv.gintSpaceBigButton)),
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
      body: ModalProgressHUD(child: Body(), inAsyncCall: gv.bolLoading),
      bottomNavigationBar: gv.clsBottom,
    );
  }
}
