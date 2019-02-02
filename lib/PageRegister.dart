// This program display the Register Page

// Import Flutter Darts
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:threading/threading.dart';

// Import Self Darts
import 'GlobalVariables.dart';
import 'LangStrings.dart';
import 'ScreenVariables.dart';
import 'Utilities.dart';

// Import Pages
import 'BottomBar.dart';
import 'PageForgetPassword.dart';
import 'PageLogin.dart';

// Register Page
class ClsRegister extends StatefulWidget {
  @override
  _ClsRegisterState createState() => _ClsRegisterState();
}

class _ClsRegisterState extends State<ClsRegister> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

  void funRegisterLogin() {
    // From Register to Login
    gv.gstrLastPage = gv.gstrCurPage;
    gv.gstrCurPage = 'Login';

    // Goto Login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClsLogin()),
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


  void funRegisterPressed() {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (ut.stringBytes(ctlUserID.text) < gv.intDefUserIDMinLen ||
          ut.stringBytes(ctlUserID.text) > gv.intDefUserIDMaxLen) {
        setState(() {
          gv.strRegisterError = ls.gs('UserIDErrorMinMaxLen');
        });
        return;
      }
      if (ut.stringBytes(ctlUserNick.text) < gv.intDefUserNickMinLen ||
          ut.stringBytes(ctlUserNick.text) > gv.intDefUserNickMaxLen) {
        setState(() {
          gv.strRegisterError = ls.gs('UserNickErrorMinMaxLen');
        });
        return;
      }
      if (!ut.isEmail(ctlUserEmail.text)) {
        setState(() {
          gv.strRegisterError = ls.gs('EmailAddressFormatError');
        });
        return;
      }
      if (ut.stringBytes(ctlUserEmail.text) > gv.intDefEmailMaxLen) {
        setState(() {
          gv.strRegisterError = ls.gs('EmailAddressFormatError');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) < gv.intDefUserPWMinLen ||
          ut.stringBytes(ctlUserPW.text) > gv.intDefUserPWMaxLen) {
        setState(() {
          gv.strRegisterError = ls.gs('UserPWErrorMinMaxLen');
        });
        return;
      }
      if (ut.stringBytes(ctlUserPW.text) != ut.stringBytes(ctlUserPWConfirm.text)) {
        setState(() {
          gv.strRegisterError = ls.gs('RegisterErrorConfirmPassword');
        });
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        setState(() {
          gv.strRegisterError = ls.gs('NetworkDisconnectedTryLater');
        });
        return;
      }

      // Reset register result
      gv.aryRegisterResult = [];

      // Show Loading
      setState(() {
        gv.bolLoading = true;
      });

      // Send to server that client wants to login
      gv.socket.emit('Register', [ctlUserID.text, ctlUserPW.text, ctlUserNick.text, ctlUserEmail.text, gv.gstrLang]);

      // Start Login Time in ms
      gv.timRegister = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryRegisterResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timRegister > gv.intSocketTimeout) {
              setState(() {
                gv.bolLoading = false;
              });
              gv.strRegisterError = ls.gs('RegisterErrorTimeout');
            } else {
              // Not Yet Timout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryRegisterResult[0] == '0000') {
              gv.bolLoading = false;

              // Show Register Success
              ut.showToast(ls.gs('RegisterSuccess'), true);

              // Goto Login
              gv.gstrLastPage = 'Register';
              gv.gstrCurPage = 'Login';
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClsLogin()),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            } else if (gv.aryRegisterResult[0] == '1000') {
              gv.strRegisterError = ls.gs('RegisterErrorUserIDExist');
              setState(() {
                gv.bolLoading = false;
              });
            } else {
              // Show Register Failed
              gv.strRegisterError = ls.gs('RegisterErrorSystem');
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
  final ctlUserNick = TextEditingController();
  final ctlUserEmail = TextEditingController();
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
                Text(gv.strRegisterError, style: TextStyle(color: Colors.red)),
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
                        controller: ctlUserNick,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: ls.gs('UserNick'),
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
                          onPressed: () => funRegisterPressed(),
                          child: Text(ls.gs('Register'),
                              style: TextStyle(
                                  fontSize: sv.dblDefaultFontSize * 1)),
                        ),
                      ),
                    ),
                    Text(ut.Space(sv.gintSpaceBigButton)),
                  ],
                ),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(5)),
                    Expanded(
                      child: SizedBox(
                        height: sv.dblDefaultFontSize * 2.5,
                        child: FlatButton(
                            textColor: Colors.blue,
                            onPressed: () => funRegisterLogin(),
                            child: Text(
                              ls.gs('Login'),
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
            ls.gs('Register'),
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
