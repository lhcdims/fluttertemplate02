// Import Flutter Darts
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Import Self Darts
import 'GlobalVariables.dart';
import 'LangStrings.dart';
import 'ScreenVariables.dart';

// Import Pages
import 'PageActivate.dart';
import 'PageChangePassword.dart';
import 'PageForgetPassword.dart';
import 'PageHome.dart';
import 'PageLogin.dart';
import 'PagePersonalInformation.dart';
import 'PageRegister.dart';
import 'PageSelectLanguage.dart';
import 'PageSettingsMain.dart';

// Main Program
void main() async {
  // Set Orientation to PortraitUp
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Init Screen Variables
  await sv.Init();

  // Init Global Vars and SharedPreference
  await gv.Init();
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
  await gv.initSocket();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable Show Debug

      home: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here Return Page According to gv.gstrCurPage
    switch (gv.gstrCurPage) {
      case 'ActivateAccount':
        return ClsActivateAccount();
        break;
      case 'ChangePassword':
        return ClsChangePassword();
        break;
      case 'ForgetPassword':
        return ClsForgetPassword();
        break;
      case 'Home':
        return ClsHome();
        break;
      case 'Login':
        return ClsLogin();
        break;
      case 'PersonalInformation':
        return StoreProvider(
          store: gv.storePerInfo,
          child: StoreConnector<int, int>(
            builder: (BuildContext context, int intTemp) {
              return ClsPersonalInformation(intTemp);
            },
            converter: (Store<int> sintTemp) {
              return sintTemp.state;
            },
          ),
        );
        break;
      case 'Register':
        return ClsRegister();
        break;
      case 'SelectLanguage':
        return ClsSelectLanguage();
        break;
      case 'SettingsMain':
        return StoreProvider(
          store: gv.storeSettingsMain,
          child: StoreConnector<int, int>(
            builder: (BuildContext context, int intTemp) {
              return ClsSettingsMain(intTemp);
            },
            converter: (Store<int> sintTemp) {
              return sintTemp.state;
            },
          ),
        );
        break;
    }
    return ClsHome();
  }
}
