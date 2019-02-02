// This program display the Forget Password Page

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

// Register Page
class ClsForgetPassword extends StatefulWidget {
  @override
  _ClsForgetPasswordState createState() => _ClsForgetPasswordState();
}

class _ClsForgetPasswordState extends State<ClsForgetPassword> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funSendPressed() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (!ut.isEmail(ctlUserEmail.text)) {
        setState(() {
          gv.strForgetPWError = ls.gs('EmailAddressFormatError');
        });
        return;
      }
      if (ut.stringBytes(ctlUserEmail.text) > gv.intDefEmailMaxLen) {
        setState(() {
          gv.strForgetPWError = ls.gs('EmailAddressFormatError');
        });
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strForgetPWError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset register result
      gv.aryForgetPWResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to login
      gv.socket.emit('ForgetPassword', [ctlUserEmail.text, gv.gstrLang]);

      // Start Login Time in ms
      gv.timForgetPW = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryForgetPWResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timForgetPW > gv.intSocketTimeout) {
              setState(() {
                gv.bolLoading = false;
              });
              gv.strForgetPWError = ls.gs('TimeoutError');
            } else {
              // Not Yet Timout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryForgetPWResult[0] == '0000') {
              gv.bolLoading = false;

              // Show Forget Password Email Sent
              ut.showToast(ls.gs('PlsCheckEmailForIDAndPasword'), true);

              // Goto Settings Main
              gv.gstrLastPage = gv.gstrCurPage;
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
            } else if (gv.aryForgetPWResult[0] == '1000') {
              gv.strForgetPWError = ls.gs('EmailNotFound');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Forget Password System Error
              gv.strForgetPWError = ls.gs('SystemError');
              setState(() {
                gv.bolLoading = false;
              });
            }
          }
        }
      });
    }
  }

  final ctlUserEmail = TextEditingController();

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
                Text(gv.strForgetPWError, style: TextStyle(color: Colors.red)),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: ctlUserEmail,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: ls.gs('EmailAddress'),
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
                          onPressed: () => funSendPressed(),
                          child: Text(ls.gs('Send'),
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
            ls.gs('ForgetPassword'),
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
