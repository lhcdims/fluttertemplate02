// import flutter darts
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:threading/threading.dart";

// import self darts
import 'Home.dart';
import 'gv.dart';
import 'LangStrings.dart';
import 'Login.dart';
import 'SelectLanguage.dart';
import 'SettingsMain.dart';
import 'tmpSettings.dart';

// Main Program
void main() {
  // Init Screen Vars
  clsSettings.Init();

  // Init Global Vars and SharedPreference
  gv.Init().then((_) {
    // Get Previous Selected Language, if any
    gv.gstrLang = gv.getString('strLang');
    if (gv.gstrLang != '') {
      // Set Current Language
      LangStrings.setLang(gv.gstrLang);

      // Already has Current Language, so set first page to SettingsMain
      gv.gstrCurPage = 'SettingsMain';
      gv.gstrLastPage = 'SettingsMain';
    } else {
      // First Time Use, set Current Language to English
      LangStrings.setLang('EN');
    }

    // Init socket.io
    gv.initSocket();

    // Set Orientation to PortraitUp
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      // Run MainApp
      runApp(new MyApp());
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
    // Set funTimerDefault, to listen to change of Vars
    var threadTimerDefault = new Thread(funTimerDefault);
    threadTimerDefault.start();
  }

  void funTimerDefault() async {
    bool bolChanged = false;
    while (true) {
      await Thread.sleep(500);

      // Check if gstrCurPage Changed
      // Which means that user want to change to another page
      // i.e. need to re-render Main Page
      // gstrCurTop Changed, should re-render page
      bolChanged = false;

      if (gv.strLogin != gv.strLoginLast) {
        bolChanged = true;
        gv.strLoginLast = gv.strLogin;
      }

      if (bolChanged) {
        switch (gv.gstrCurPage) {
          case 'Login':
            setState(() {
            });
            break;
          default:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable Debug
      debugShowCheckedModeBanner: false,

      home: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class, if any
  }

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
        return ClsSettingsMain();
        break;
    }
  }
}
