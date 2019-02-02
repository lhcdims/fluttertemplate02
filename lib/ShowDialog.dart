// This program display the Dialog

// Import Flutter Darts
import 'package:flutter/material.dart';

// Import Self Darts
import 'GlobalVariables.dart';
import 'LangStrings.dart';
import 'ScreenVariables.dart';

// Show Dialog Class sd
class sd {
  // The original widget calls the following showAlert method in async mode
  // Which means that, after calling showAlert, the codes after showAlert will be run immediately
  // i.e. Anything showAlert should be done, must be done inside showAlert.
  // In other words, the original widget must be using Redux for State Management.  (CANNOT use setState)
  // inside showDialog, can use either:
  // 1. AlertDialog (To show 1 row of buttons at the bottom)
  // 2. SimpleDialog (To show rows of buttons)
  // See Below examples for AlertDialog (case 'Logout') and SimpleDialog (case 'Logout2')
  static void showAlert(BuildContext context, strTitle, strContent, strAction) {
    switch (strAction) {
      case 'Logout':
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text(strTitle),
                  content: Text(strContent),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text(ls.gs('Yes')),
                      onPressed: () {
                        Navigator.of(context).pop();
                        gv.gstrCurPage = 'SettingsMain';

                        // Do Logout
                        gv.strLoginID = '';
                        gv.strLoginPW = '';
                        gv.strLoginStatus = '';
                        gv.setString('strLoginID', gv.strLoginID);
                        gv.setString('strLoginPW', gv.strLoginPW);

                        // Call Server to Logout
                        gv.socket.emit('LogoutFromServer', []);

                        // Increment storeSettingsMain to refresh page
                        gv.storeSettingsMain.dispatch(Actions.Increment);
                      },
                    ),
                    new FlatButton(
                      child: new Text(ls.gs('No')),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
        break;
      case 'Logout2':
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SimpleDialog(
                  title: Center(
                    child: Text(strTitle + ': ' + strContent),
                  ),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                        gv.gstrCurPage = 'SettingsMain';

                        // Do Logout
                        gv.strLoginID = '';
                        gv.strLoginPW = '';
                        gv.strLoginStatus = '';
                        gv.setString('strLoginID', gv.strLoginID);
                        gv.setString('strLoginPW', gv.strLoginPW);

                        // Call Server to Logout
                        gv.socket.emit('LogoutFromServer', []);

                        // Increment storeSettingsMain to refresh page
                        gv.storeSettingsMain.dispatch(Actions.Increment);
                      },
                      child: Center(
                        child: Text(
                          ls.gs('Yes'),
                          style: TextStyle(
                              fontSize: sv.dblDefaultFontSize * 1.2,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          ls.gs('No'),
                          style: TextStyle(
                              fontSize: sv.dblDefaultFontSize * 1.2,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ));
        break;
      default:
        break;
    }
  }
}
