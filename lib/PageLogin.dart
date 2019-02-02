// This program display the Login Page

// Import Flutter Darts
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:redux/redux.dart';
import 'package:threading/threading.dart';

// Import Self Darts
import 'GlobalVariables.dart';
import 'LangStrings.dart';
import 'ScreenVariables.dart';
import 'Utilities.dart';

// Import Pages
import 'PageActivate.dart';
import 'BottomBar.dart';
import 'PageForgetPassword.dart';
import 'PageRegister.dart';
import 'PageSettingsMain.dart';

// Login Page
class ClsLogin extends StatefulWidget {
  @override
  _ClsLoginState createState() => _ClsLoginState();
}

class _ClsLoginState extends State<ClsLogin> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funLoginRegister() {
    // From Login to Register
    gv.gstrLastPage = gv.gstrCurPage;
    gv.gstrCurPage = 'Register';

    // Goto Register
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClsRegister()),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }



  void funLoginForgetPW() {
    // From Login to ForgetPW
    gv.gstrLastPage = gv.gstrCurPage;
    gv.gstrCurPage = 'ForgetPassword';

    // Goto Register
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClsForgetPassword()),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }



  void funLoginPressed() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (ut.stringBytes(ctlUserID.text) < gv.intDefUserIDMinLen ||
          ut.stringBytes(ctlUserID.text) > gv.intDefUserIDMaxLen) {
        setState(() {
          gv.strLoginError = ls.gs('UserIDErrorMinMaxLen');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) < gv.intDefUserPWMinLen ||
          ut.stringBytes(ctlUserPW.text) > gv.intDefUserPWMaxLen) {
        setState(() {
          gv.strLoginError = ls.gs('UserPWErrorMinMaxLen');
        });
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strLoginError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset login result
      gv.aryLoginResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to login
      gv.socket.emit('LoginToServer', [ctlUserID.text, ctlUserPW.text, true]);

      // Start Login Time in ms
      gv.timLogin = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryLoginResult.toString() == '[]') {
            // this means the server not yet return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timLogin > gv.intSocketTimeout) {
              // Assume Login Fail after 10 seconds (gv.intSocketTimeout = 10000 in gv.dart)
              gv.strLoginError = ls.gs('LoginErrorTimeout');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Not Yet Timeout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryLoginResult[0] == '0000') {
              gv.bolLoading = false;

              // Save Login ID & PW in Memory
              gv.strLoginID = ctlUserID.text;
              gv.strLoginPW = ctlUserPW.text;

              // Save Login ID & PW in SharedPreferences
              gv.setString('strLoginID', gv.strLoginID);
              gv.setString('strLoginPW', gv.strLoginPW);

              // Goto Activate or SettingsMain
              if (gv.strLoginStatus == 'D') {
                // Show Account Disabled
                ut.showToast(ls.gs('AccountDisabled'), true);
              } else {
                // Show Login Success
                ut.showToast(ls.gs('LoginSuccess'), true);
              }

              if (gv.strLoginStatus == 'A') {
                // Goto Activate
                gv.gstrCurPage = 'ActivateAccount';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClsActivateAccount()),
                );
              } else {
                // Goto Settings Main
                gv.gstrCurPage = 'SettingsMain';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreProvider(
                          store: gv.storeSettingsMain,
                          child: StoreConnector<int, int>(
                            builder: (BuildContext context, int intTemp) {
                              return ClsSettingsMain(intTemp);
                            },
                            converter: (Store<int> sintTemp) {
                              return sintTemp.state;
                            },
                          ),
                        )));
              }
              // Reset Routes
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            } else if (gv.aryLoginResult[0] == '1000') {
              // Show Login Failed
              gv.strLoginError = ls.gs('LoginErrorUserIDPassword');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Other Error, Login Failed
              gv.strLoginError = ls.gs('LoginErrorSystem');
              setState(() {
                gv.bolLoading = false;
              });
            }
          }
        }
      });
    }
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(' '),
                Text(gv.strLoginError, style: TextStyle(color: Colors.red)),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
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
                      child: TextField(
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
                          child: Text(ls.gs('Login'),
                              style: TextStyle(
                                  fontSize: sv.dblDefaultFontSize * 1)),
                        ),
                      ),
                    ),
                    Text(ut.Space(sv.gintSpaceBigButton)),
                  ],
                ),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(5)),
                    Expanded(
                      child: SizedBox(
                        height: sv.dblDefaultFontSize * 2.5,
                        child: FlatButton(
                            textColor: Colors.blue,
                            onPressed: () => funLoginRegister(),
                            child: Text(
                              ls.gs('Register'),
                              style: TextStyle(
                                fontSize: sv.dblDefaultFontSize * 1,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ),
                    ),
                    Text(ut.Space(5)),
                    Expanded(
                      child: SizedBox(
                        height: sv.dblDefaultFontSize * 2.5,
                        child: FlatButton(
                            textColor: Colors.blue,
                            onPressed: () => funLoginForgetPW(),
                            child: Text(
                              ls.gs('ForgetPassword'),
                              style: TextStyle(
                                fontSize: sv.dblDefaultFontSize * 1,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ),
                    ),
                    Text(ut.Space(5)),
                  ],
                ),
              ],
            ),
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
      bottomNavigationBar: ClsBottom(),
    );
  }
}
