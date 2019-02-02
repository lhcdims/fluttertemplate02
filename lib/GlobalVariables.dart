// This program stores ALL global variables required by ALL darts

// Import Flutter Darts
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threading/threading.dart';

// Import Self Darts
import 'LangStrings.dart';
import 'Utilities.dart';

// Import Pages

enum Actions {
  Increment
} // The reducer, which takes the previous count and increments it in response to an Increment action.
int reducerRedux(int intSomeInteger, dynamic action) {
  if (action == Actions.Increment) {
    return intSomeInteger + 1;
  }
  return intSomeInteger;
}

class gv {
  // Current Page
  // gstrCurPage stores the Current Page to be loaded
  static var gstrCurPage = 'SelectLanguage';
  static var gstrLastPage = 'SelectLanguage';

  // Init gintBottomIndex
  // i.e. Which Tab is selected in the Bottom Navigator Bar
  static var gintBottomIndex = 1;

  // Declare Language
  // i.e. Language selected by user
  static var gstrLang = '';

  // bolLoading is used by the 'package:modal_progress_hud/modal_progress_hud.dart'
  // Inside a particular page that use Modal_Progress_Hud  :
  // Set it to true to show the 'Loading' Icon
  // Set it to false to hide the 'Loading' Icon
  static bool bolLoading = false;

  // Defaults

  // Allow Duplicate Login?
  // static const bool bolAllowDuplicateLogin = false;

  // Min / Max of Fields
  // User ID from 3 to 20 Bytes
  static const int intDefUserIDMinLen = 3;
  static const int intDefUserIDMaxLen = 20;
  // Password from 6 to 20 Bytes
  static const int intDefUserPWMinLen = 6;
  static const int intDefUserPWMaxLen = 20;
  // Nick Name from 3 to 20 Bytes
  static const int intDefUserNickMinLen = 3;
  static const int intDefUserNickMaxLen = 20;
  static const int intDefEmailMaxLen = 60;
  // Activation Code Length
  static const int intDefActivateLength = 6;

  // Declare STORE here for Redux

  // Store for SettingsMain
  static Store<int> storeSettingsMain =
      new Store<int>(reducerRedux, initialState: 0);
  static Store<int> storePerInfo =
      new Store<int>(reducerRedux, initialState: 0);

  // Declare SharedPreferences && Connectivity
  static var NetworkStatus;
  static SharedPreferences pref;
  static Init() async {
    pref = await SharedPreferences.getInstance();

    // Detect Connectivity
    NetworkStatus = await (Connectivity().checkConnectivity());
    if (NetworkStatus == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print('Mobile Network');
    } else if (NetworkStatus == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print('WiFi Network');
    }
  }

  static getString(strKey) {
    var strResult = '';
    strResult = pref.getString(strKey) ?? '';
    return strResult;
  }

  static setString(strKey, strValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(strKey, strValue);
  }

  // Vars For Pages

  // Var For Activate
  static var strActivateError = '';
  static var aryActivateResult = [];
  static var timActivate = DateTime.now().millisecondsSinceEpoch;

  // Var For Change Password
  static var strChangePWError = '';
  static var aryChangePWResult = [];
  static var timChangePW = DateTime.now().millisecondsSinceEpoch;

  // Var For Forget Password
  static var strForgetPWError = '';
  static var aryForgetPWResult = [];
  static var timForgetPW = DateTime.now().millisecondsSinceEpoch;

  // Var For Login
  static var strLoginID = '';
  static var strLoginPW = '';
  static var strLoginError = '';
  static var aryLoginResult = [];
  static var strLoginStatus = '';
  static var bolFirstTimeCheckLogin = false;
  static var timLogin = DateTime.now().millisecondsSinceEpoch;

  // Var For PersonalInformation
  static var strPerInfoError = ls.gs('ChangeEmailNeedActivateAgain');
  static var aryPerInfoResult = [];
  static var timPerInfo = DateTime.now().millisecondsSinceEpoch;
  static var strPerInfoUsr_NickL = '';
  static var strPerInfoUsr_EmailL = '';
  static var ctlPerInfoUserNick = TextEditingController();
  static var ctlPerInfoUserEmail = TextEditingController();
  static bool bolPerInfoFirstCall = false;

  // Var For Register
  static var strRegisterError = ls.gs('EmailAddressRegisterWarning');
  static var aryRegisterResult = [];
  static var timRegister = DateTime.now().millisecondsSinceEpoch;

  // Var For ShowDialog
  static int intShowDialogIndex = 0;

  // socket.io related
  static const String URI = 'http://thisapp.zephan.top:10531';
  static bool gbolSIOConnected = false;
  static SocketIO socket;
  static int intSocketTimeout = 10000;
  static int intHBInterval = 5000;

  static initSocket() async {
    if (!gbolSIOConnected) {
      socket = await SocketIOManager().createInstance(URI);
    }
    socket.onConnect((data) {
      gbolSIOConnected = true;
      print('onConnect');
      ut.showToast(ls.gs('NetworkConnected'));

      if (!bolFirstTimeCheckLogin) {
        bolFirstTimeCheckLogin = true;
        // Check Login Again if strLoginID != ''
        if (strLoginID != '') {
          timLogin = DateTime.now().millisecondsSinceEpoch;
          socket.emit('LoginToServer', [strLoginID, strLoginPW, false]);
        }
      }
    });
    socket.onConnectError((data) {
      gbolSIOConnected = false;
      print('onConnectError');
    });
    socket.onConnectTimeout((data) {
      gbolSIOConnected = false;
      print('onConnectTimeout');
    });
    socket.onError((data) {
      gbolSIOConnected = false;
      print('onError');
    });
    socket.onDisconnect((data) {
      gbolSIOConnected = false;
      print('onDisconnect');
      ut.showToast(ls.gs('NetworkDisconnected'));
    });

    // Socket Return from socket.io server

    socket.on('ActivateResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timActivate >
          intSocketTimeout) {
        print('Activate result timeout');
        return;
      }
      aryActivateResult = data;
    });

    socket.on('ChangePasswordResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timChangePW >
          intSocketTimeout) {
        print('ChangePasswordResult Timeout');
        return;
      }
      aryChangePWResult = data;
    });

    socket.on('ChangePerInfoResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timPerInfo >
          intSocketTimeout) {
        print('ChangePerInfo Result Timeout');
        return;
      }
      aryPerInfoResult = data;
    });

    socket.on('ForceLogoutByServer', (data) {
      // Force Logout By Server (Duplicate Login)

      // Clear User ID
      strLoginID = '';
      strLoginPW = '';
      strLoginStatus = '';
      setString('strLoginID', strLoginID);
      setString('strLoginPW', strLoginPW);

      // Show Long Toast
      ut.showToast(ls.gs('LoginErrorReLogin'), true);

      // Reset States
      resetStates();
    });

    socket.on('ForgetPasswordResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timForgetPW >
          intSocketTimeout) {
        print('ForgetPasswordResult Timeout');
        return;
      }
      aryForgetPWResult = data;
    });

    socket.on('GetPerInfoResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timPerInfo >
          intSocketTimeout) {
        print('GetPerInfo Result Timeout');
        return;
      }
      aryPerInfoResult = data;

      strPerInfoUsr_NickL = gv.aryPerInfoResult[1][0]['usr_nick'];
      strPerInfoUsr_EmailL = gv.aryPerInfoResult[1][0]['usr_email'];

      bolLoading = false;
      ctlPerInfoUserNick.text = gv.strPerInfoUsr_NickL;
      ctlPerInfoUserEmail.text = gv.strPerInfoUsr_EmailL;
    });

    socket.on('LoginResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timLogin > intSocketTimeout) {
        print('login result timeout');
        return;
      }

      // Get User Status
      if (data[2].length != 0) {
        strLoginStatus = data[2][0]['usr_status'];
        print('strLoginStatus: ' + strLoginStatus);
      }

      if (data[1] != true) {
        // Not the First Time Login, but a Re-Login
        // Change SettingsMain Login/Logout State
        if (data[0] == '0000') {
          // Re-Login Successful
          // Nothing Changed
          if (strLoginStatus == 'A' && gstrCurPage == 'SettingsMain') {
            storeSettingsMain.dispatch(Actions.Increment);
          }
        } else {
          // Re-Login Failed
          strLoginID = '';
          strLoginPW = '';
          strLoginStatus = '';
          setString('strLoginID', strLoginID);
          setString('strLoginPW', strLoginPW);
          if (gstrCurPage == 'SettingsMain') {
            storeSettingsMain.dispatch(Actions.Increment);
          }
          // Display Toast Message

        }
      } else {
        // First Time Login, return aryLoginResult
        aryLoginResult = data;
      }
    });

    socket.on('RegisterResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timRegister >
          intSocketTimeout) {
        print('Register result timeout');
        return;
      }
      aryRegisterResult = data;
    });

    socket.on('SendEmailAgainResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timActivate >
          intSocketTimeout) {
        print('Send Email Again Timeout');
        return;
      }
      aryActivateResult = data;
    });

    // Connect Socket
    socket.connect();

    // Create a thread to send HeartBeat
    var threadHB = new Thread(funTimerHeartBeat);
    threadHB.start();
  } // End of initSocket()

  // HeartBeat Timer
  static void funTimerHeartBeat() async {
    while (true) {
      await Thread.sleep(intHBInterval);
      if (socket != null) {
        // print('Sending HB...' + DateTime.now().toString());
        socket.emit('HB', [0]);
      }
    }
  } // End of funTimerHeartBeat()

  // Reset All variables
  static void resetVars() {
    // Reset Vars for Activate
    strActivateError = ls.gs('ActivationCodeWarning');

    // Reset Vars for Login
    strLoginError = '';

    // Reset Vars for Register
    strRegisterError = ls.gs('EmailAddressRegisterWarning');

    // Reset Vars for Per Info
    strPerInfoError = ls.gs('ChangeEmailNeedActivateAgain');

    // Reset Vars for Change Password
    strChangePWError = '';

    // Reset Vars for Forget Password
    strForgetPWError = '';
  }

  // Reset All states
  static void resetStates() {
    switch (gstrCurPage) {
      case 'PersonalInformation':
        storeSettingsMain.dispatch(Actions.Increment);
        break;
      case 'SettingsMain':
        storeSettingsMain.dispatch(Actions.Increment);
        break;
      default:
        break;
    }
  }
} // End of class gv
