// This program display the Personal Information Page

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
class ClsPersonalInformation extends StatelessWidget {
  final intState;

  ClsPersonalInformation(this.intState);

  bool bolGotPerInfo = false;

  void funChangePressed(context) {
    if (!gv.bolLoading) {
      gv.resetVars();

      // Validate Input
      if (ut.stringBytes(gv.ctlPerInfoUserNick.text) <
          gv.intDefUserNickMinLen ||
          ut.stringBytes(gv.ctlPerInfoUserNick.text) >
              gv.intDefUserNickMaxLen) {
        gv.strPerInfoError = ls.gs('UserNickErrorMinMaxLen');
        gv.storePerInfo.dispatch(Actions.Increment);
        return;
      }
      if (!ut.isEmail(gv.ctlPerInfoUserEmail.text)) {
        gv.strPerInfoError = ls.gs('EmailAddressFormatError');
        gv.storePerInfo.dispatch(Actions.Increment);
        return;
      }
      if (ut.stringBytes(gv.ctlPerInfoUserEmail.text) > gv.intDefEmailMaxLen) {
        gv.strPerInfoError = ls.gs('EmailAddressFormatError');
        gv.storePerInfo.dispatch(Actions.Increment);
        return;
      }
      if (gv.ctlPerInfoUserNick.text == gv.strPerInfoUsr_NickL && gv.ctlPerInfoUserEmail.text == gv.strPerInfoUsr_EmailL) {
        // Nothing Changed
        ut.showToast(ls.gs('NothingChanged'), true);

        // Goto SettingsMain
        gv.gstrLastPage = gv.gstrCurPage;
        gv.gstrCurPage = 'SettingsMain';
        Navigator.pushAndRemoveUntil(context,
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
              )),
              (_) => false,
        );
        return;
      }

      // Check Network Connection
      if (!gv.gbolSIOConnected) {
        gv.strPerInfoError = ls.gs('NetworkDisconnectedTryLater');
        gv.storePerInfo.dispatch(Actions.Increment);
        return;
      }

      // Reset register result
      gv.aryPerInfoResult = [];

      // Show Loading
      gv.bolLoading = true;
      gv.storePerInfo.dispatch(Actions.Increment);

      // Check Email Changed or not
      bool bolEmailChanged = false;
      if (gv.ctlPerInfoUserEmail.text != gv.strPerInfoUsr_EmailL) {
        print('Current Email: ' + gv.ctlPerInfoUserEmail.text);
        print('Last Email: ' + gv.strPerInfoUsr_EmailL);
        bolEmailChanged = true;
      }

      // Send to server that client wants to change Personal Information
      gv.socket.emit('ChangePerInfo', [
        gv.strLoginID,
        gv.ctlPerInfoUserNick.text,
        gv.ctlPerInfoUserEmail.text,
        bolEmailChanged,
        gv.gstrLang
      ]);

      // Start PerInfo Time in ms
      gv.timPerInfo = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryPerInfoResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timPerInfo >
                gv.intSocketTimeout) {
              gv.bolLoading = false;
              gv.strPerInfoError = ls.gs('TimeoutError');
              gv.storePerInfo.dispatch(Actions.Increment);
            } else {
              // Not Yet Timout, so Continue Loading
            }
          } else {
            // this means that server has returned some values
            if (gv.aryPerInfoResult[0] == '0000') {
              gv.bolLoading = false;

              // Show Change Personal Information Success
              if (!bolEmailChanged) {
                ut.showToast(ls.gs('PersonalInformationChanged'), true);
              } else {
                gv.strLoginStatus = 'A';
                ut.showToast(ls.gs('EmailChangedNeedActivateAgain'), true);
              }

              // Goto SettingsMain
              gv.gstrLastPage = gv.gstrCurPage;
              gv.gstrCurPage = 'SettingsMain';
              Navigator.pushAndRemoveUntil(context,
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
                    )),
                    (_) => false,
              );
            } else {
              // Show Change Personal Information Failed
              gv.strPerInfoError = ls.gs('SystemError');
              gv.bolLoading = false;
              gv.storePerInfo.dispatch(Actions.Increment);
            }
          }
        }
      });
    }
  }


  Widget Body(context) {
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
                Text(gv.strPerInfoError, style: TextStyle(color: Colors.red)),
                Text(' '),
                Text(' '),
                Row(
                  children: <Widget>[
                    Text(ut.Space(sv.gintSpaceTextField)),
                    Expanded(
                      child: TextField(
                        controller: gv.ctlPerInfoUserNick,
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
                        controller: gv.ctlPerInfoUserEmail,
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
                          onPressed: () => funChangePressed(context),
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
    if (gv.bolPerInfoFirstCall) {
      gv.bolPerInfoFirstCall = false;

      // Set bolLoading = true
      gv.bolLoading = true;
      gv.storePerInfo.dispatch(Actions.Increment);

      gv.resetVars();

      // Reset PerInfo Result
      gv.aryPerInfoResult = [];

      // Send to server Get Personal Information
      gv.socket.emit('GetPerInfo', [gv.strLoginID]);

      // Start PerInfo Time in ms
      gv.timPerInfo = DateTime.now().millisecondsSinceEpoch;

      new Future.delayed(new Duration(milliseconds: 100), () async {
        while (gv.bolLoading) {
          await Thread.sleep(100);
          // Use string to check if it is array
          if (gv.aryPerInfoResult.toString() == '[]') {
            // this means the server didnt return any value
            if (DateTime.now().millisecondsSinceEpoch - gv.timPerInfo >
                gv.intSocketTimeout) {
              gv.bolLoading = false;
              ut.showToast(ls.gs('TimeoutError'), true);
            } else {
              // Not Yet Timout, so Continue Loading
            }
          } else {
            gv.bolLoading = false;
          }
        }

        // This is CRAZY here !!!
        // Cannot dispatch storePerInfo, but storeSettingsMain
        // Otherwise the "Loading" icon does not disappear!!!
        gv.storePerInfo.dispatch(Actions.Increment);
        print('PerInfo Dispatched');
      });
    }
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('PersonalInformation'),
            style: TextStyle(fontSize: sv.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(sv.dblTopHeight),
      ),
      body: ModalProgressHUD(child: Body(context), inAsyncCall: gv.bolLoading),
      bottomNavigationBar: ClsBottom(),
    );
  }
}

