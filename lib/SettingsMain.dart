// This program display the Settings Main Page

// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';
import 'Utilities.dart';

// Import Pages
import 'Activate.dart';
import 'ChangePassword.dart';
import 'bottom.dart';
import 'Login.dart';
import 'PersonalInformation.dart';
import 'SelectLanguage.dart';


// Home Page
class ClsSettingsMain extends StatelessWidget {
  final intState;

  ClsSettingsMain(this.intState);

  // Vars for SettingsMain
  static var listSettingsMain = [
    // list of Buttons in this page
    {'Prog': 'SelectLanguage'},
    {'Prog': 'Login'},
  ];

  // Choose which page when button pressed
  void funSettingsMain (strProg, context) {
    // Set LastPage
    gv.gstrLastPage = gv.gstrCurPage;

    // Go to Next Page
    gv.gstrCurPage = strProg;

    // Code to Goto Next Page
    switch (strProg) {
      case 'ActivateAccount':
        gv.resetVars();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsActivateAccount()),
        );
        break;
      case 'ChangePassword':
        gv.resetVars();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsChangePassword()),
        );
        break;
      case 'PersonalInformation':
        if (!gv.bolLoading) {

          // Check Network Connection
          if (!gv.gbolSIOConnected) {
            ut.showToast(ls.gs('NetworkDisconnectedTryLater'), true);
            return;
          }

          gv.bolPerInfoFirstCall = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoreConnector<int, int>(
                builder: (BuildContext context, int intTemp) {
                  return ClsPersonalInformation(intTemp);
                }, converter: (Store<int> sintTemp) {
              return sintTemp.state;
            })),
          );
        };
        break;
      case 'SelectLanguage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsSelectLanguage()),
        );
        break;
      case 'Login':
        gv.resetVars();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClsLogin()),
        );
        break;
      case 'Logout':
        // Do Logout
        gv.strLoginID = '';
        gv.strLoginPW = '';
        gv.strLoginStatus = '';
        gv.setString('strLoginID', gv.strLoginID);
        gv.setString('strLoginPW', gv.strLoginPW);

        // Increment storeSettingsMain to refresh page
        gv.storeSettingsMain.dispatch(Actions.Increment);

        // Call Server to Logout
        gv.socket.emit('LogoutFromServer', []);

        break;
      default:
        break;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }


  @override
  Widget build(BuildContext context) {
    // Set listSettingsMain according to gv.strLogin
    if (gv.strLoginID == '') {
      listSettingsMain = [
        // list of Buttons in this page
        {'Prog': 'SelectLanguage'},
        {'Prog': 'Login'},
      ];
    } else {
      if (gv.strLoginStatus == 'A') {
        listSettingsMain = [
          // list of Buttons in this page
          {'Prog': 'SelectLanguage'},
          {'Prog': 'PersonalInformation'},
          {'Prog': 'ChangePassword'},
          {'Prog': 'ActivateAccount'},
          {'Prog': 'Logout'},
        ];
      } else {
        listSettingsMain = [
          // list of Buttons in this page
          {'Prog': 'SelectLanguage'},
          {'Prog': 'PersonalInformation'},
          {'Prog': 'ChangePassword'},
          {'Prog': 'Logout'},
        ];
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            ls.gs('Settings'),
            style: TextStyle(fontSize: sv.dblDefaultFontSize),
          ),
        ),
        preferredSize: new Size.fromHeight(sv.dblTopHeight),
      ),
      body: Container(
        height: sv.dblBodyHeight,
        width: sv.dblScreenWidth,
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listSettingsMain.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(' '),
                    Row(children: <Widget>[
                      Text('                         ',
                          textAlign: TextAlign.center),
                      Expanded(
                        child: SizedBox(
                          height: sv.dblDefaultFontSize * 2.5,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    sv.dblDefaultRoundRadius)),
                            textColor: Colors.white,
                            color: Colors.greenAccent,
                            onPressed: () => funSettingsMain(
                                listSettingsMain[index]['Prog'], context),
                            child: Text(
                                '${ls.gs(listSettingsMain[index]['Prog'])}',
                                style: TextStyle(
                                    fontSize:
                                        sv.dblDefaultFontSize * 1)),
                          ),
                        ),
                      ),
                      Text('                         ',
                          textAlign: TextAlign.center),
                    ]),
                    Text(' '),
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: ClsBottom(),
    );
  }
}
