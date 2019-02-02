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
class ClsActivateAccount extends StatefulWidget {
  @override
  _ClsActivateAccountState createState() => _ClsActivateAccountState();
}

class _ClsActivateAccountState extends State<ClsActivateAccount> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funSendActivationEmailAgain() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strActivateError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset Activate result
      gv.aryActivateResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to send activation email again
      gv.socket.emit('SendEmailAgain', [gv.strLoginID, gv.gstrLang]);

      // Start Activate Time in ms
      gv.timActivate = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryActivateResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timActivate > gv.intSocketTimeout) {
              gv.strActivateError = ls.gs('SystemError');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Not Yet Timeout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryActivateResult[0] == '0000') {
              // Show Email Sent
              ut.showToast(ls.gs('ActivationEmailSent'),true);
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              gv.strActivateError = ls.gs('SystemError');
              // Other Error, Show System Error
              setState(() {
                gv.bolLoading = false;
              });
            }
          }
        }
      });
    }
  }

  void funActivatePressed() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (ut.stringBytes(ctlActivateCode.text) != ctlActivateCode.text.length ||
          ut.stringBytes(ctlActivateCode.text) != gv.intDefActivateLength) {
        setState(() {
          gv.strActivateError = ls.gs('ActivateError');
        });
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strActivateError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset Activate result
      gv.aryActivateResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to activate
      gv.socket.emit('ActivateToServer', [gv.strLoginID, ctlActivateCode.text]);

      // Start Activate Time in ms
      gv.timActivate = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryActivateResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timActivate > gv.intSocketTimeout) {
              gv.strActivateError = ls.gs('ActivateErrorTimeout');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Not Yet Timeout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryActivateResult[0] == '0000') {
              gv.bolLoading = false;

              // Show Activate success
              ut.showToast(ls.gs('ActivateSuccess'),true);

              // Save Login Status in Memory
              gv.strLoginStatus = 'E';

              // Goto SettingsMain
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
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            } else if (gv.aryActivateResult[0] == '0100') {
              // Show Already Activate
              gv.bolLoading = false;

              // Show Activate success
              ut.showToast(ls.gs('ActivateAlready'),true);

              // Save Login Status in Memory
              gv.strLoginStatus = 'E';

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
            } else if (gv.aryActivateResult[0] == '0200') {
              // Show Account Disabled
              gv.strActivateError = ls.gs('AccountDisabled');
              setState(() {
                gv.bolLoading = false;
              });
            } else if (gv.aryActivateResult[0] == '0300') {
              // Show Activate Failed
              gv.strActivateError = ls.gs('ActivateError');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              gv.strActivateError = ls.gs('SystemError');
              // Other Error, Activate Failed
              setState(() {
                gv.bolLoading = false;
              });
            }
          }
        }
      });
    }
  }

  final ctlActivateCode = TextEditingController();

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
                Text(gv.strActivateError, style: TextStyle(color: Colors.red)),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: ctlActivateCode,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: ls.gs('ActivationCode'),
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
                          onPressed: () => funActivatePressed(),
                          child: Text(ls.gs('Activate'),
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
                            onPressed: () => funSendActivationEmailAgain(),
                            child: Text(
                              ls.gs('SendActivationEmailAgain'),
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
            ls.gs('ActivateAccount'),
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
