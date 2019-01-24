// import flutter darts
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:threading/threading.dart";

// import self darts
import 'gv.dart';
import 'LangStrings.dart';
import 'tmpSettings.dart';

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
    // Set funTimerDefault, to listen to change of Vars
    var threadTimerDefault = new Thread(funTimerDefault);
    threadTimerDefault.start();
  }

  void funTimerDefault() async {
    bool bolChanged = false;
    while (true) {
      // Allow this thread to run each XXX milliseconds
      await Thread.sleep(500);

      bolChanged = false;

      // Check any changes need to setState here

      // If anything changes
      // setState according to gv.gstrCurPage
      if (bolChanged) {
        switch (gv.gstrCurPage) {
          case 'Login':
            setState(() {});
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
      // Disable Show Debug
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
        return gv.clsHome;
        break;
      case 'Login':
        return gv.clsLogin;
        break;
      case 'SelectLanguage':
        return gv.clsSelectLanguage;
        break;
      case 'SettingsMain':
        return gv.clsSettingsMain;
        break;
    }
    return gv.clsHome;
  }
}
