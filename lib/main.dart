// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Import Self Darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';

// Import Pages
import 'Home.dart';
import 'Login.dart';
import 'SelectLanguage.dart';
import 'SettingsMain.dart';

// Main Program
void main() {
  // Set Orientation to PortraitUp
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // Init Screen Variables
    sv.Init();

    // Init Global Vars and SharedPreference
    gv.Init().then((_) {
      // Get Previous Selected Language from SharedPreferences, if any
      gv.gstrLang = gv.getString('strLang');
      gv.strLoginID = gv.getString('strLoginID');
      gv.strLoginPW = gv.getString('strLoginPW');
      if (gv.gstrLang != '') {
        // Set Current Language
        ls.setLang(gv.gstrLang);

        // Already has Current Language, so set first page to SettingsMain
        gv.gstrCurPage = 'SettingsMain';
        gv.gstrLastPage = 'SettingsMain';
      } else {
        // First Time Use, set Current Language to English
        ls.setLang('EN');
      }

      // Run MainApp
      runApp(new MyApp());

      // Init socket.io
      gv.initSocket();
    });
  });
}

// Main App
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: gv.storeSettingsMain,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable Show Debug

        home: MainBody(),
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here Return Page According to gv.gstrCurPage
    switch (gv.gstrCurPage) {
      case 'Home':
        return ClsHome();
        break;
      case 'Login':
        return ClsLogin();
        break;
      case 'SelectLanguage':
        return ClsSelectLanguage();
        break;
      case 'SettingsMain':
        return StoreConnector<int, int>(
          builder: (BuildContext context, int intTemp) {
            return ClsSettingsMain(intTemp);
          }, converter: (Store<int> sintTemp) {
          return sintTemp.state;
        },);
        break;
      case 'Logout':
        return StoreConnector<int, int>(
          builder: (BuildContext context, int intTemp) {
            return ClsSettingsMain(intTemp);
          }, converter: (Store<int> sintTemp) {
          return sintTemp.state;
        },);
        break;
    }
    return ClsHome();
  }
}
