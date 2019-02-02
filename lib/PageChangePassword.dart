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
import 'BottomBar.dart';
import 'PageSettingsMain.dart';

// Login Page
class ClsChangePassword extends StatefulWidget {
  @override
  _ClsChangePasswordState createState() => _ClsChangePasswordState();
}

class _ClsChangePasswordState extends State<ClsChangePassword> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funChangePressed() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (ut.stringBytes(ctlUserPWOld.text) < gv.intDefUserPWMinLen ||
          ut.stringBytes(ctlUserPWOld.text) > gv.intDefUserPWMaxLen) {
        setState(() {
          gv.strChangePWError = ls.gs('UserPWErrorMinMaxLen');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) < gv.intDefUserPWMinLen ||
          ut.stringBytes(ctlUserPW.text) > gv.intDefUserPWMaxLen) {
        setState(() {
          gv.strChangePWError = ls.gs('UserPWErrorMinMaxLen');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) ==
          ut.stringBytes(ctlUserPWOld.text)) {
        setState(() {
          gv.strChangePWError = ls.gs('OldPasswordCannotBeTheSameAsNewPassword');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) !=
          ut.stringBytes(ctlUserPWConfirm.text)) {
        setState(() {
          gv.strChangePWError = ls.gs('RegisterErrorConfirmPassword');
        });
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strChangePWError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset login result
      gv.aryChangePWResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to change password
      gv.socket.emit('ChangePassword', [gv.strLoginID, ctlUserPWOld.text, ctlUserPW.text]);

      // Start ChangePW Time in ms
      gv.timChangePW = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryChangePWResult.toString() == '[]') {
            // this means the server not yet return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timChangePW >
                gv.intSocketTimeout) {
              gv.strChangePWError = ls.gs('TimeoutError');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Not Yet Timeout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryChangePWResult[0] == '0000') {
              gv.bolLoading = false;

              // Save Login ID & PW in Memory
              gv.strLoginPW = ctlUserPW.text;

              // Save Login ID & PW in SharedPreferences
              gv.setString('strLoginPW', gv.strLoginPW);

              // Show Password Changed
              ut.showToast(ls.gs('PasswordChanged'), true);

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
              // Reset Routes
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            } else if (gv.aryChangePWResult[0] == '1000') {
              gv.strChangePWError = ls.gs('OldPasswordIsNotCorrect');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Other Error
              gv.strChangePWError = ls.gs('SystemError');
              setState(() {
                gv.bolLoading = false;
              });
            }
          }
        }
      });
    }
  }

  final ctlUserPWOld = TextEditingController();
  final ctlUserPW = TextEditingController();
  final ctlUserPWConfirm = TextEditingController();

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
                Text(gv.strChangePWError, style: TextStyle(color: Colors.red)),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: ctlUserPWOld,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: ls.gs('PasswordOld'),
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
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: ctlUserPW,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: ls.gs('PasswordNew'),
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
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: ctlUserPWConfirm,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: ls.gs('UserPWConfirm'),
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
                          onPressed: () => funChangePressed(),
                          child: Text(ls.gs('Change'),
                              style: TextStyle(
                                  fontSize: sv.dblDefaultFontSize * 1)),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('ChangePassword'),
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
