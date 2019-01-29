// This program stores ALL global variables required by ALL darts

// Import Flutter Darts
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threading/threading.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:redux/redux.dart';
import 'package:connectivity/connectivity.dart';

// Import Self Darts
import 'LangStrings.dart';
import 'Utilities.dart';

// Import Pages


enum Actions { Increment } // The reducer, which takes the previous count and increments it in response to an Increment action.
int reducerSettingsMain(int intSomeInteger, dynamic action) {
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
  static const int intDefUserIDMinLen = 3;
  static const int intDefUserIDMaxLen = 20;
  static const int intDefUserPWMinLen = 6;
  static const int intDefUserPWMaxLen = 20;
  static const int intDefUserNickMinLen = 3;
  static const int intDefUserNickMaxLen = 20;




  // Declare STORE here for Redux

  // Store for SettingsMain
  static Store<int> storeSettingsMain = new Store<int>(reducerSettingsMain, initialState: 0);






  // Declare SharedPreferences && Connectivity
  static var NetworkStatus;
  static SharedPreferences pref;
  static Init() async {
    pref = await SharedPreferences.getInstance();
    NetworkStatus = await (Connectivity().checkConnectivity());
    // Detect Connectivity

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








  // Var For Login
  static var strLoginID = '';
  static var strLoginPW = '';
  static var strLoginError = '';
  static var aryLoginResult = [];
  static var timLogin = DateTime.now().millisecondsSinceEpoch;

  // Var For Register
  static var strRegisterError = ls.gs('EmailAddressRegisterWarning');
  static var aryRegisterResult = [];
  static var timRegister = DateTime.now().millisecondsSinceEpoch;


  // socket.io related
  static const String URI = 'http://thisapp.zephan.top:10531';
  static bool gbolSIOConnected = false;
  static SocketIO socket;
  static int intSocketTimout = 5000;
  static int intHBInterval = 5000;

  static initSocket() async {
    if (!gbolSIOConnected) {
      socket = await SocketIOManager().createInstance(URI);
    }
    socket.onConnect((data) {
      gbolSIOConnected = true;
      print('onConnect');
      ut.showToast(ls.gs('NetworkConnected'));
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

    socket.on('LoginResult', (data) {
      // Check if the result comes back too late
      if (DateTime.now().millisecondsSinceEpoch - timLogin > intSocketTimout) {
        print('login result timeout');
        return;
      }
      if (data[1] != true) {
        // Not the First Time Login, but a Re-Login
        // Change SettingsMain Login/Logout State
        if (data[0] == '0000') {
          // Re-Login Successful
          // Nothing Changed
        } else {
          // Re-Login Failed
          strLoginID = '';
          strLoginPW = '';
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


    socket.on('ForceLogoutByServer', (data) {
      // Force Logout By Server (Duplicate Login)

      // Clear User ID
      strLoginID = '';
      strLoginPW = '';
      setString('strLoginID', strLoginID);
      setString('strLoginPW', strLoginPW);

      // Show Long Toast
      ut.showToast(ls.gs('LoginErrorReLogin'), true);

      // Reset States
      resetStates();
    });

    socket.connect();

    // Create a thread to send HeartBeat
    var threadHB = new Thread(funTimerHeartBeat);
    threadHB.start();

    // Check Login Again if strLoginID != ''
    if (strLoginID != '') {
      gv.socket.emit('LoginToServer', [strLoginID, strLoginPW, false]);
    }
  } // End of initSocket()



  // HeartBeat Timer
  static void funTimerHeartBeat() async {
    while (true) {
      await Thread.sleep(intHBInterval);
      if (socket != null) {
        print('Sending HB...' + DateTime.now().toString());
        socket.emit('HB',[0]);
      }
    }
  } // End of funTimerHeartBeat()



  // Reset All variables
  static void resetVars() {
    strLoginError = '';
    strRegisterError = ls.gs('EmailAddressRegisterWarning');
  }

  // Reset All states
  static void resetStates() {
    switch (gstrCurPage) {
      case 'SettingsMain':
        storeSettingsMain.dispatch(Actions.Increment);
        break;
      default:
        break;
    }
  }
}  // End of class gv
