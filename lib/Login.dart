// This program display the Login Page

// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:threading/threading.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';
import 'Utilities.dart';

// Import Pages
import 'bottom.dart';
import 'SettingsMain.dart';

// Login Page
class ClsLogin extends StatefulWidget {
  @override
  _ClsLoginState createState() => _ClsLoginState();
}

class _ClsLoginState extends State<ClsLogin> {
  int intCounter = 0;

  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funLoginPressed() {
    gv.resetVars();

    bool bolLoadingLast = true;

    // Validate Input
    if (ut.stringBytes(ctlUserID.text) < gv.intDefUserIDMinLen || ut.stringBytes(ctlUserID.text) > gv.intDefUserIDMaxLen) {
      setState(() {
        gv.strLoginError = ls.gs('UserIDErrorMinMaxLen');
      });
      return;
    }
    if (ut.stringBytes(ctlUserPW.text) < gv.intDefUserPWMinLen || ut.stringBytes(ctlUserPW.text) > gv.intDefUserPWMaxLen) {
      setState(() {
        gv.strLoginError = ls.gs('UserPWErrorMinMaxLen');
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
          // this means the server didnt return any value
          if (DateTime.now().millisecondsSinceEpoch - gv.timLogin > 5000) {
            gv.bolLoading = false;
            //ut.showToast(ls.gs('LoginFailed'));
            gv.strLoginError = ls.gs('LoginErrorTimeout');
            if (gv.bolLoading != bolLoadingLast) {
              bolLoadingLast = gv.bolLoading;
              setState(() {
                gv.bolLoading = false;
              });
            }
          } else {
            // Continue Loading
            gv.bolLoading = true;
            if (gv.bolLoading != bolLoadingLast) {
              bolLoadingLast = gv.bolLoading;
              setState(() {
                gv.bolLoading = true;
              });
            }
          }
        } else {
          // this means that server has returned some values
          if (gv.aryLoginResult[0] == '0000') {
            gv.bolLoading = false;
            print('Login Success');
            // Hide Loading
            if (gv.bolLoading != bolLoadingLast) {
              bolLoadingLast = gv.bolLoading;
              setState(() {
                gv.bolLoading = false;
              });
            }
            // Show Login success
            ut.showToast(ls.gs('LoginSuccess'));

            // Save Login ID & PW in Memory
            gv.strLoginID = ctlUserID.text;
            gv.strLoginPW = ctlUserPW.text;

            // Save Login ID & PW in SharedPreferences
            gv.setString('strLoginID', gv.strLoginID);
            gv.setString('strLoginPW', gv.strLoginPW);

            // Goto SettingsMain
            gv.gstrCurPage = 'SettingsMain';
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreConnector<int, int>(
                          builder: (BuildContext context, int intTemp) {
                        return ClsSettingsMain(intTemp);
                      }, converter: (Store<int> sintTemp) {
                        return sintTemp.state;
                      })),
            );
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          } else if (gv.aryLoginResult[0] == '1000') {
            gv.bolLoading = false;
            // Show Login Failed
            // ut.showToast(ls.gs('LoginFailed'));
            gv.strLoginError = ls.gs('LoginErrorUserIDPassword');
            // Hide Loading
            if (gv.bolLoading != bolLoadingLast) {
              bolLoadingLast = gv.bolLoading;
              setState(() {
                gv.bolLoading = false;
              });
            }
            // Do other things

          } else {
            // Other Error, Login Failed
            gv.bolLoading = false;
            // Show Login Failed
            gv.strLoginError = ls.gs('LoginErrorSystem');
            if (gv.bolLoading != bolLoadingLast) {
              bolLoadingLast = gv.bolLoading;
              setState(() {
                gv.bolLoading = false;
              });
            }
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
      bottomNavigationBar: ClsBottom(),
    );
  }
}
